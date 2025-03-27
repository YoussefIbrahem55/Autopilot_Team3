% The aerodynamic forces and moments can be expressed as a function of all the motion variables [Nelson] page 63

%% Step 1: Clear workspace and close figures
clc;
clear all;
close all;

%% Step 2: Load Excel Sheet Data
filename_density_L = 'B747_FC5'; %% Specify the location of your Excel sheet

aircraft_data = xlsread(filename_density_L, 'B2:B61'); %% Read data from Excel (B2:B61)

%% Step 3: Extract Time Vector Parameters
dt = aircraft_data(1);  % Time step
tfinal = 2000 %aircraft_data(2); % Final time
lengths = tfinal/dt + 1; % Total number of time steps
time_V = (0:dt:tfinal)'; % Time vector

%% Step 4: Extract Initial Conditions
s0 = aircraft_data(4:15); % Initial state variables
wdot0 = 0; % Initial angular acceleration
sdot0 = zeros(12,1); % Zero initial state derivatives
Vto = sqrt(s0(1)^2 + s0(2)^2 + s0(3)^2); % Initial velocity magnitude
initial_conditions = [aircraft_data(13:15)' aircraft_data(10:12)' aircraft_data(4:6)' aircraft_data(7:9)' aircraft_data(18) aircraft_data(20) Vto 0] ;
%% Step 5: Define Control Inputs
dc = [0 0 0 0*180/pi]*pi/180;%[aircraft_data(57:59)* pi/180; aircraft_data(60)]; % Control surface deflections
da= dc(1);
dr= dc(2);
de= dc(3);
dth=dc(4);


%% Step 6: Define Gravity, Mass, and Inertia Parameters
m = aircraft_data(51); % Mass
g = aircraft_data(52); % Gravity acceleration
Ixx = aircraft_data(53);
Iyy = aircraft_data(54);
Izz = aircraft_data(55);
Ixz = aircraft_data(56);
Ixy = 0;
Iyz = 0;
I = [Ixx, -Ixy, -Ixz;
    -Ixy, Iyy, -Iyz;
    -Ixz, -Iyz, Izz]; % Inertia matrix
invI = inv(I); % Inverse of inertia matrix
% initial gravity force
F_gravity_0 = m*g * [ sin(s0(8)) ;
    -cos(s0(8))*sin(s0(7)) ;
    -cos(s0(8))*cos(s0(7)) ];
M0 = [0; 0; 0];
%% Step 7: Load Stability Derivatives
% Longitudinal Motion Derivatives
SD_Long = aircraft_data(21:36);
SD_Long_final = SD_Long;

% Lateral Motion Derivatives
SD_Lat_dash = aircraft_data(37:50);
run('LateralFunc'); % Run lateral derivatives transformation script
SD_Lat_final = SD_Lat;

%% Step 8: Solve Equations of Motion using RK4 Method
states(:,1) = s0;
for i = 1:lengths
    if i == 1
        wdot = wdot0;
    end

    % Compute Forces and Moments
    [F, M,Matrix_states,Matrix_Controls] = afModel(SD_Long_final, SD_Lat_final, [states(:,i); wdot], [s0; wdot0], dc, m, g, I);

    % Runge-Kutta 4th Order Method (RK4)
    K_1 = get_states_dot(time_V(i), states(:,i), F, M, I, m);
    K_2 = get_states_dot(time_V(i) + dt/2, states(:,i) + dt*K_1/2, F, M, I, m);
    K_3 = get_states_dot(time_V(i) + dt/2, states(:,i) + dt*K_2/2, F, M, I, m);
    K_4 = get_states_dot(time_V(i) + dt, states(:,i) + dt*K_3, F, M, I, m);

    % Update State Variables
    states(:,i+1) = states(:,i) + (dt/6) * (K_1 + 2*K_2 + 2*K_3 + K_4);
    wdot = K_1(3);
end

states = states(:,1:lengths);

%% Step 10: States Rearrangement

u = states(1,:);
v = states(2,:);
w = states(3,:);
p_deg = states(4,:)*180/pi;
q_deg = states(5,:)*180/pi;
r_deg = states(6,:)*180/pi;
phi_deg =states(7,:)*180/pi;
theta_deg =states(8,:)*180/pi;
psi_deg =states(9,:)*180/pi;
x = states(10,:);
y = states(11,:);
z = round(states(12,:),5);
alpha_deg = atan(w./u)*180/pi;
beta_deg = asin(v./sqrt(u.^2+v.^2+w.^2))*180/pi;
states_vec_kutta = [
    u
    v;
    w;
    beta_deg;
    alpha_deg;
    p_deg;
    q_deg;
    r_deg;
    phi_deg;
    theta_deg;
    psi_deg;
    x;
    y;
    z;

    ];

%% Longitudnal
% full linear model


A = [Xu  Xw  -w0  -9.81*cos(theta0)  ;
    Zu/(1-Zwd)   Zw/(1-Zwd)  (Zq+u0)/(1-Zwd)  (-9.81*sin(theta0))/(1-Zwd) ;
    Mu+Mw*(Zu/(1-Zwd))  Mw+Mw*(Zw/(1-Zwd))  Mq+Mw*(Zq+u0)/(1-Zwd)  -Mw*(-9.81*sin(theta0))/(1-Zwd) ;
    0 0 1 0 ;];
% delta_controls : [d_aileron d_rudder d_elevator d_thrust]

B = [Xde  Xdth ;
    Zde/(1-Zwd)  Zdth/(1-Zwd);
    Mde+Mwd*(Zde/(1-Zwd))  Mdth+Mwd*(Zdth/(1-Zwd));
    0 0 ;];
C=eye(4,4);
D=zeros(4,2);
% TF of full model

all_tf=tf(ss(A,B,C,D));


tf_ue=all_tf(1,1);
tf_uth=all_tf(1,2);
tf_we=all_tf(2,1);
tf_wth=all_tf(2,2);
tf_qe=all_tf(3,1);
tf_qth=all_tf(3,2);
tf_thetae=all_tf(4,1);
tf_thetath=all_tf(4,2);




% long period


A_long_period=[Xu+(w0*Zu)/(Zq+u0) -9.81*cos(theta0)-(w0*9.81*sin(theta0)/(Zq+u0));
    -Zu/(Zq+u0) (9.81*sin(theta0))/(Zq+u0) ;];

B_long_period=[Xde+(w0*Zde)/(Zq+u0) Xdth+(w0*Zdth)/(Zq+u0);
    -Zde/(Zq+u0) -Zdth/(Zq+u0) ; ];

% TF of long peroid
long_peroid_TF=tf(ss(A_long_period,B_long_period,eye(2,2),zeros(2,2)));
tf_ue_long=long_peroid_TF(1,1);
tf_uth_long=long_peroid_TF(1,2);
tf_thetae_long=long_peroid_TF(2,1);
tf_thetath_long=long_peroid_TF(2,2);



% short peroid

A_short_period = [Zw/(1-Zwd), (Zq+u0)/(1-Zwd);
    Mw+Mwd*Zw/(1-Zwd), Mq+Mwd*(Zq+u0)/(1-Zwd)];
B_short_period = [Zde/(1-Zwd), Zdth/(1-Zwd);
    Mde+Mwd*Zde/(1-Zwd), Mdth+Mwd*Zdth/(1-Zwd)];
C_short = eye(2); D_short = zeros(2,2);

% TF of short peroid
short_peroid_TF=tf(ss(A_short_period,B_short_period,eye(2,2),zeros(2,2)));

tf_we_short=short_peroid_TF(1,1);
tf_wth_short=short_peroid_TF(1,2);
tf_qe_short=short_peroid_TF(2,1);
tf_qth_short=short_peroid_TF(2,1);


%
de= 0;
dth=10000;
sim('Aircraft_Simulator_full_long');
t=full_long.Time;
%full long data
full_u= full_long.Data(:,1);
full_w= full_long.Data(:,2);
full_q= full_long.Data(:,3);
full_theta= full_long.Data(:,4);

%long peroid data

long_u=long_peroid.Data(:,1);
long_theta=long_peroid.Data(:,2);

%short peroid data

short_w=short_peroid.Data(:,1);
short_q=short_peroid.Data(:,2);
%% Lateral

