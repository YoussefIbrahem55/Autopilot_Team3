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
tfinal = aircraft_data(2); % Final time
lengths = tfinal/dt + 1; % Total number of time steps
time_V = (0:dt:tfinal)'; % Time vector

%% Step 4: Extract Initial Conditions
s0 = aircraft_data(4:15); % Initial state variables
Vto = sqrt(s0(1)^2 + s0(2)^2 + s0(3)^2); % Initial velocity magnitude
initial_conditions = [aircraft_data(13:15)' aircraft_data(10:12)' aircraft_data(4:6)' aircraft_data(7:9)' aircraft_data(18) aircraft_data(20) Vto 0] ;
wdot0 = 0; % Initial angular acceleration
sdot0 = zeros(12,1); % Zero initial state derivatives
%Vto = sqrt(s0(1)^2 + s0(2)^2 + s0(3)^2); % Initial velocity magnitude

%% Step 5: Define Control Inputs
dc = [aircraft_data(57:59) * pi/180; aircraft_data(60)]; % Control surface deflections
da=dc(1);
dr=dc(2);
de=dc(3);
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
    [F, M] = afModel(SD_Long_final, SD_Lat_final, [states(:,i); wdot], [s0; wdot0], dc, m, g, I);
    
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

%% Step 9: Plot State Comparisons

%plotStateComparisons(time_V', states);
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
    u;
    v;
    w;
    p_deg;
    q_deg;
    r_deg;
    phi_deg;
    theta_deg;
    psi_deg;
    x;
    y;
    z;
    alpha_deg;
    beta_deg
    ];
P=[x; y; z];
%% Eng wessam Validation
run('validation_helper')
%% Before Sim
% stability derivatives Longitudinal motion
SD_Long = aircraft_data(21:36);
SD_Long_final = SD_Long;
Temp_Long = num2cell(SD_Long_final);
[Xu, Zu, Mu, Xw, Zw, Mw, Zwd, Zq, Mwd, Mq, Xde, Zde, Mde, Xdth, Zdth, Mdth] = deal(Temp_Long{:});


%%  Getting the Useful derivatives

% stability derivatives Lateral motion
SD_Lat_dash = aircraft_data(37:50);
G = 1/(1-(Ixz^2)/(Ixx*Izz));

Yda = SD_Lat_dash(9) * Vto;
Ydr = SD_Lat_dash(10) *Vto;
T = [G G*Ixz/Ixx; G*Ixz/Izz G];
Trans_MAT = inv(T);
r = Trans_MAT * [SD_Lat_dash(7); SD_Lat_dash(8)];
p = Trans_MAT * [SD_Lat_dash(5); SD_Lat_dash(6)];
B = Trans_MAT * [SD_Lat_dash(3); SD_Lat_dash(4)];
DR = Trans_MAT * [SD_Lat_dash(11); SD_Lat_dash(12)];
DA = Trans_MAT * [SD_Lat_dash(13); SD_Lat_dash(14)];

Lr = r(1); Nr = r(2); Lp = p(1); Np = p(2); Lb = B(1); Nb = B(2);
Ldr = DR(1); Ndr = DR(2); Lda = DA(1); Nda = DA(2);
Yv = SD_Lat_dash(1); Yb = SD_Lat_dash(2);

Lv = Lb/Vto;
Nv = Nb/Vto;
Yp = 0;
Yr = 0;


% SD_Lat_final = [ SD_Lat(1) ; SD_Lat(3) ; SD_Lat(4) ; SD_Lat(5) ; SD_Lat(6) ;...
%                  SD_Lat(7) ; SD_Lat(8) ; SD_Lat(9:10) ; SD_Lat(11) ; SD_Lat(12) ;...
%                   SD_Lat(13) ; SD_Lat(14) ];

% initial gravity force
F_gravity_0 = m*g * [ sin(s0(8)) ; -cos(s0(8))*sin(s0(7)) ; -cos(s0(8))*cos(s0(7)) ];
M0 = [0; 0; 0];
x_0 = aircraft_data(14);
y_0 = aircraft_data(15);
z_0 = aircraft_data(16);

%% Matricies

Matrix_states = [Xu  0   Xw  0   0   0   0
    0   Yv  0   Yp  0   Yr  0
    Zu  0   Zw  0   Zq  0   Zwd
    0   Lv  0   Lp  0   Lr  0
    Mu  0   Mw  0   Mq  0   Mwd
    0   Nv  0   Np  0   Nr  0 ];


Matrix_Controls = [ 0    Xde Xdth  0
    Yda  0   0     Ydr
    0    Zde Zdth  0
    Lda  0   0     Ldr
    0    Mde Mdth  0
    Nda  0   0     Ndr];
sim('Aircraft_Simulator.slx');
sim_vec = [
    out_u out_v out_w out_p out_q out_r out_phi out_theta out_psi out_x out_y out_z out_alpha out_beta
    ];
plotStateComparisons(time_V, states_vec_kutta, tout', sim_vec)
%figure
%plot(tout,out_x.Data)