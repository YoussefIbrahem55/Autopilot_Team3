% The aerodynamic forces and moments can be expressed as a function of all the motion variables [Nelson] page 63

%% Step 1: Clear workspace and close figures
clc;
clear all;
close all;

%% Step 2: Load Excel Sheet Data
filename_density_L = 'JetstarFC3'; %% Specify the location of your Excel sheet

aircraft_data = xlsread(filename_density_L, 'B2:B61'); %% Read data from Excel (B2:B61)

%% Step 3: Extract Time Vector Parameters
dt = aircraft_data(1);  % Time step
tfinal = aircraft_data(2); % Final time
lengths = tfinal/dt + 1; % Total number of time steps
time_V = (0:dt:tfinal)'; % Time vector

%% Step 4: Extract Initial Conditions
s0 = aircraft_data(4:15); % Initial state variables
wdot0 = 0; % Initial angular acceleration
sdot0 = zeros(12,1); % Zero initial state derivatives
Vto = sqrt(s0(1)^2 + s0(2)^2 + s0(3)^2); % Initial velocity magnitude
initial_conditions = [aircraft_data(13:15)' aircraft_data(10:12)' aircraft_data(4:6)' aircraft_data(7:9)' aircraft_data(18) aircraft_data(20) Vto 0] ;
alpha0 = atan(s0(3)/s0(1));
beta0 = asin(s0(2)/Vto) ;
w0=s0(3); 
theta0=s0(8);
U0=s0(1); 
v0 = s0(2);
p0 = s0(4);
q0 = s0(5);
r0 = s0(6);
phi0 = s0(7);
psi0 = s0(9);
%% Step 5: Define Control Inputs
dc = [aircraft_data(57:59)* pi/180; aircraft_data(60)]; % Control surface deflections
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
run('LateralFunction'); % Run lateral derivatives transformation script
SD_Lat_final = SD_Lat;
Lb_dash=SD_Lat_dash(3);
Nb_dash =SD_Lat_dash(4);
Lp_dash=SD_Lat_dash(5);
Np_dash=SD_Lat_dash(6);
Lr_dash=SD_Lat_dash(7);
Nr_dash =SD_Lat_dash(8);
Yda_star =SD_Lat_dash(9);
Ydr_star=SD_Lat_dash(10);    
Lda_dash =SD_Lat_dash(11);
Nda_dash =SD_Lat_dash(12);
Ldr_dash = SD_Lat_dash(13);
Ndr_dash= SD_Lat_dash(14);
Lv = Lb_dash ;
Nv = Nb_dash ;  
Y_p = 0 ;
Y_r = 0 ;
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
%% simulation
sim('Aircraft_Simulator_LAT.slx');

sim_vec = [
    out_u';out_beta'; out_alpha';  out_p'; out_q'; out_r'; out_phi'; out_theta'; out_psi'; out_x'; out_y'; out_z'
    ];
%plotStateComparisons(time_V, states_vec_kutta, tout', sim_vec',dc)
%% Lateral full linearized 
A_lat = [Y_beta/Vto      ,  (Y_p+w0)/Vto  ,   (Y_r-U0)/Vto   , (g*cos(theta0))/Vto , 0 ;
         Lb_dash ,  Lp_dash  ,   Lr_dash   ,        0        , 0 ;
         Nb_dash ,  Np_dash  ,   Nr_dash   ,        0        , 0 ;
         0       ,     1     , tan(theta0) ,        0        , 0 ;
         0       ,     0     , sec(theta0) ,        0        , 0 ];

B_lat = [Yda_star      , Ydr_star      ;
         Lda_dash , Ldr_dash ;
         Nda_dash , Ndr_dash ;
         0        ,  0       ;
         0        ,  0      ];

C_lat = eye(5);
D_lat = zeros(5,2);

%% state space model and tfs for full linear lateral Appro. states

[tf_num_da,tf_dom_da] = ss2tf(A_lat,B_lat,C_lat,D_lat,1);
[tf_num_dr,tf_dom_dr] = ss2tf(A_lat,B_lat,C_lat,D_lat,2);

%tf for lateral due to aileron
tf_full_beta_da    = minreal( tf(tf_num_da(1,:) , tf_dom_da) )
tf_full_p_da    = minreal( tf(tf_num_da(2,:) , tf_dom_da) )
tf_full_r_da    = minreal( tf(tf_num_da(3,:) , tf_dom_da) )
tf_full_phi_da  = minreal( tf(tf_num_da(4,:) , tf_dom_da) )
tf_full_psi_da  = minreal( tf(tf_num_da(5,:) , tf_dom_da) )

%tf for lateral due to rudder
tf_full_beta_dr    = minreal( tf(tf_num_dr(1,:) , tf_dom_dr) )
tf_full_p_dr    = minreal( tf(tf_num_dr(2,:) , tf_dom_dr) )
tf_full_r_dr    = minreal( tf(tf_num_dr(3,:) , tf_dom_dr) )
tf_full_phi_dr  = minreal( tf(tf_num_dr(4,:) , tf_dom_dr) )
tf_full_psi_dr  = minreal( tf(tf_num_dr(5,:) , tf_dom_dr) )
%% The lateral inputs

da_input = (pi/180)*[1 5 10 25] ;  % rad 
dr_input = (pi/180)*[1 5 10 25] ;  % rad 

ail  = size(da_input);
rud  = size(dr_input);
ail  = ail(2);
rud  = rud(2);

% the full linear Appro. response

% for aileron inputs
[beta_linear_cases_da,p_linear_cases_da,r_linear_cases_da,phi_linear_cases_da,psi_linear_cases_da,t_beta_linear_cases_da,t_p_linear_cases_da,t_r_linear_cases_da,t_phi_linear_cases_da,t_psi_linear_cases_da] = lat_response(ail,da_input,tf_num_da,tf_dom_da,tfinal,v0,p0,r0,phi0,psi0);

% for rudder inputs 
[beta_linear_cases_dr,p_linear_cases_dr,r_linear_cases_dr,phi_linear_cases_dr,psi_linear_cases_dr,t_beta_linear_cases_dr,t_p_linear_cases_dr,t_r_linear_cases_dr,t_phi_linear_cases_dr,t_psi_linear_cases_dr] = lat_response(rud,dr_input,tf_num_dr,tf_dom_dr,tfinal,v0,p0,r0,phi0,psi0);
%%  3 DOF (Dutch Roll Approximation)

% states space model and tfs

A_lat_DR = [Y_v      , 0  ,   -1   ;
            Lb_dash , Lp_dash  ,    0    ;
            Nb_dash ,    0     , Nr_dash ];

B_lat_DR = [Yda_star      , Ydr_star      ;
            Lda_dash , Ldr_dash ;
            Nda_dash , Ndr_dash ];

C_lat_DR = eye(3);
D_lat_DR = zeros(3,2);


% tfs of states with delta_aileron
[tf_num_DR_da,tf_dom_DR_da]   = ss2tf(A_lat_DR,B_lat_DR,C_lat_DR,D_lat_DR,1);

tf_DR_beta_da = minreal( tf(tf_num_DR_da(1,:) , tf_dom_DR_da) )
tf_DR_p_da = minreal( tf(tf_num_DR_da(2,:) , tf_dom_DR_da) )
tf_DR_r_da = minreal( tf(tf_num_DR_da(3,:) , tf_dom_DR_da) )


% tfs of states with delta_rudder
[tf_num_DR_dr,tf_dom_DR_dr]   = ss2tf(A_lat_DR,B_lat_DR,C_lat_DR,D_lat_DR,2);

tf_DR_beta_dr = minreal( tf(tf_num_DR_dr(1,:) , tf_dom_DR_dr) )
tf_DR_p_dr = minreal( tf(tf_num_DR_dr(2,:) , tf_dom_DR_dr) )
tf_DR_r_dr = minreal( tf(tf_num_DR_dr(3,:) , tf_dom_DR_dr) )
%% Dutch Roll Approximations results

Ics_DR = [v0 , p0 , r0];

%due to da
[ssss , sta_t] = lat_approx_response(3,da_input,tf_num_DR_da,tf_dom_DR_da,tfinal,Ics_DR);
% note that the states position had been changed
beta_DR_da = squeeze(ssss(1,:,:))';    tbeta_DR_da = squeeze(sta_t(1,:,:))';
p_DR_da = squeeze(ssss(2,:,:))';       tp_DR_da = squeeze(sta_t(2,:,:))';
r_DR_da = squeeze(ssss(3,:,:))';       tr_DR_da = squeeze(sta_t(3,:,:))';

%due to dr
[ssss_2 , sta_t_2] = lat_approx_response(3,dr_input,tf_num_DR_dr,tf_dom_DR_dr,tfinal,Ics_DR);
beta_DR_dr = squeeze(ssss_2(1,:,:))';    tbeta_DR_dr = squeeze(sta_t_2(1,:,:))';
p_DR_dr = squeeze(ssss_2(2,:,:))';    tp_DR_dr = squeeze(sta_t_2(2,:,:))';
r_DR_dr = squeeze(ssss_2(3,:,:))';    tr_DR_dr = squeeze(sta_t_2(3,:,:))';
%% 3 DOF (spiral Approximation)

% states space model and tfs

A_lat_spiral = [Lp_dash , Lr_dash , 0 ;
                Np_dash , Nr_dash , 0 ;
                    1   ,    0    , 0 ];

B_lat_spiral = [Ldr_dash ;
                Ndr_dash ;
                    0   ];

C_lat_spiral = eye(3);
D_lat_spiral = zeros(3,1);


% tfs of states with delta_rudder
[tf_num_spiral_dr,tf_dom_spiral_dr]   = ss2tf(A_lat_spiral,B_lat_spiral,C_lat_spiral,D_lat_spiral);

tf_spiral_p_dr    = minreal( tf(tf_num_spiral_dr(1,:) , tf_dom_spiral_dr) )
tf_spiral_r_dr    = minreal( tf(tf_num_spiral_dr(2,:) , tf_dom_spiral_dr) )
tf_spiral_phi_dr  = minreal( tf(tf_num_spiral_dr(3,:) , tf_dom_spiral_dr) )
%% Spiral Approximations results

Ics_spiral = [ p0 , r0 , phi0];
%due to dr
[ssss_3 , sta_t_3] = lat_approx_response(3,da_input,tf_num_spiral_dr,tf_dom_spiral_dr,tfinal,Ics_spiral);
% note that the states position had been changed
p_spiral_dr     = squeeze(ssss_3(1,:,:))';        tp_spiral_dr    = squeeze(sta_t_3(1,:,:))';
r_spiral_dr     = squeeze(ssss_3(2,:,:))';        tr_spiral_dr    = squeeze(sta_t_3(2,:,:))';
phi_spiral_dr   = squeeze(ssss_3(3,:,:))';        tphi_spiral_dr  = squeeze(sta_t_3(3,:,:))';
%% 2 DOF Approximations

A_lat_2DOF_app = [Y_v      ,    -(1-Y_r/U0)   ;
                  Nb_dash ,    Nr_dash   ];

B_lat_2DOF_app = [Yda_star      , Ydr_star      ;
                  Nda_dash , Ndr_dash ];

C_lat_2DOF_app = eye(2);
D_lat_2DOF_app = zeros(2);


% tfs of states with delta_aileron
[tf_num_2DOF_da,tf_dom_2DOF_da]   = ss2tf(A_lat_2DOF_app,B_lat_2DOF_app,C_lat_2DOF_app,D_lat_2DOF_app,1);

tf_2DOF_beta_da = minreal( tf(tf_num_2DOF_da(1,:) , tf_dom_2DOF_da) )
tf_2DOF_r_da = minreal( tf(tf_num_2DOF_da(2,:) , tf_dom_2DOF_da) )


% tfs of states with delta_rudder
[tf_num_2DOF_dr,tf_dom_2DOF_dr]   = ss2tf(A_lat_2DOF_app,B_lat_2DOF_app,C_lat_2DOF_app,D_lat_2DOF_app,2);

tf_2DOF_beta_dr = minreal( tf(tf_num_2DOF_dr(1,:) , tf_dom_2DOF_dr) )
tf_2DOF_r_dr = minreal( tf(tf_num_2DOF_dr(2,:) , tf_dom_2DOF_dr) )
%% 2 DOF Approximations results

Ics_2DOF = [v0 , r0];
%due to da
[ssss_4 , sta_t_4] = lat_approx_response(2,da_input,tf_num_2DOF_da,tf_dom_2DOF_da,tfinal,Ics_2DOF);
% note that the states position had been changed
beta_2DOF_da = squeeze(ssss_4(1,:,:))';    tbeta_2DOF_da = squeeze(sta_t_4(1,:,:))';
r_2DOF_da = squeeze(ssss_4(2,:,:))';    tr_2DOF_da = squeeze(sta_t_4(2,:,:))';

%due to dr
[ssss_7 , sta_t_7] = lat_approx_response(2,dr_input,tf_num_2DOF_dr,tf_dom_2DOF_dr,tfinal,Ics_2DOF);
% note that the states position had been changed
beta_2DOF_dr = squeeze(ssss_7(1,:,:))';    tbeta_2DOF_dr = squeeze(sta_t_7(1,:,:))';
r_2DOF_dr = squeeze(ssss_7(2,:,:))';    tr_2DOF_dr = squeeze(sta_t_7(2,:,:))';



%% 1 DOF rolling Approx.

A_lat_1DOF_app = [Lp_dash];
B_lat_1DOF_app = [Lda_dash];
C_lat_1DOF_app = eye(1);
D_lat_1DOF_app = zeros(1);

[tf_num_1DOF_p_da,tf_dom_1DOF_p_da] = ss2tf(A_lat_1DOF_app,B_lat_1DOF_app,C_lat_1DOF_app,D_lat_1DOF_app);
tf_1DOF_p_da = minreal( tf(tf_num_1DOF_p_da , tf_dom_1DOF_p_da) )

[ssss_5 , sta_t_5] = lat_approx_response(1,da_input,tf_num_1DOF_p_da,tf_dom_1DOF_p_da,tfinal,p0);

p_rolling_da = squeeze(ssss_5(1,:,:))'  ; tp_rolling_da = squeeze(sta_t_5(1,:,:))';

%% simulink responce due to da and dr inputs

% da inputs

[states_sim_da_mat] = simulink_inputs(4,da_input,1);

 v_sim_da     = squeeze(states_sim_da_mat(:,:,2) );
 p_sim_da     = squeeze(states_sim_da_mat(:,:,4) );
 r_sim_da     = squeeze(states_sim_da_mat(:,:,6) );
 phi_sim_da   = squeeze(states_sim_da_mat(:,:,7));


for i = 1:1:size(da_input,2)

    set_param( 'Aircraft_Simulator_LAT/aileron','Value' , num2str( da_input(i) ) );
    sim('Aircraft_Simulator_LAT');
    psi_sim_da(:,i)   = out_psi    ;
    alpha_sim_da(:,i) = out_alpha   ;
    beta_sim_da(:,i)  = out_beta   ;

end

% dr inputs
[states_sim_dr_mat] = simulink_inputs(4,dr_input,2);

  v_sim_dr     = squeeze(states_sim_dr_mat(:,:,2) );
  p_sim_dr     = squeeze(states_sim_dr_mat(:,:,4) );
  r_sim_dr     = squeeze(states_sim_dr_mat(:,:,6) );
  phi_sim_dr   = squeeze(states_sim_dr_mat(:,:,7));

for i = 1:1:size(dr_input,2)

    set_param( 'Aircraft_Simulator_LAT/rudder','Value' , num2str( dr_input(i) ) );
    sim('Aircraft_Simulator_LAT');
    psi_sim_dr(:,i)   = out_psi    ;
    alpha_sim_dr(:,i) = out_alpha   ;
    beta_sim_dr(:,i)  = out_beta   ;

end
    set_param( 'Aircraft_Simulator_LAT/rudder','Value' , num2str( 0 ) );
%% PLOTS
%% PLOTS
x_label = 'time (s)';
y_labels = {'$\beta$ (deg)', '$\phi$ (deg)', '$\psi$ (deg)', 'p (deg/s)', 'r (deg/s)'};

% Legends with LaTeX formatting
legends = struct( ...
    'r_dr', {{'$\text{Nonlinear Model}$', '$\text{Linear Full Model}$', '$3\text{DOF Spiral}$', '$3\text{DOF Dutch Roll}$', '$2\text{DOF Dutch Roll}$'}}, ...
    'r_da', {{'$\text{Nonlinear Model}$', '$\text{Linear Full Model}$', '$3\text{DOF Dutch Roll}$', '$2\text{DOF Dutch Roll}$'}}, ...
    'beta', {{'$\text{Nonlinear Model}$', '$\text{Linear Full Model}$', '$3\text{DOF Dutch Roll}$', '$2\text{DOF Dutch Roll}$'}}, ...
    'phi', {{'$\text{Nonlinear Model}$', '$\text{Linear Full Model}$', '$3\text{DOF Spiral}$'}}, ...
    'p', {{'$\text{Nonlinear Model}$', '$\text{Linear Full Model}$', '$3\text{DOF Dutch Roll}$', '$1\text{DOF Roll}$'}}, ...
    'p_dr', {{'$\text{Nonlinear Model}$', '$\text{Linear Full Model}$', '$3\text{DOF Dutch Roll}$', '$3\text{DOF Spiral}$'}}, ...
    'psi', {{'$\text{Nonlinear Model}$', '$\text{Linear Full Model}$'}} ...
);



% Input cases
da_cases = [1, 5, 10, 25];
dr_cases = [1, 5, 10, 25];


% Loop through da cases
for i = 1:length(da_cases)
    generate_plots('da', da_cases(i), time_V, beta_da, p_da, r_da, phi_da, psi_da, t_beta_da, t_p_da, t_r_da, t_phi_da, t_psi_da, legends);
end

% Loop through dr cases
for i = 1:length(dr_cases)
    generate_plots('dr', dr_cases(i), time_V, beta_dr, p_dr, r_dr, phi_dr, psi_dr, t_beta_dr, t_p_dr, t_r_dr, t_phi_dr, t_psi_dr, legends);
end

%% plotting root locus and bode plot for lateral 
% bode plots 
% due to da 
bode_general({tf_full_beta_da,tf_DR_beta_da,tf_2DOF_beta_da},'beta due to da',leg_arr_beta(2:4));
bode_general({tf_full_p_da,tf_DR_p_da,tf_1DOF_p_da},'p due to da',leg_arr_p(2:4));
bode_general({tf_full_r_da,tf_DR_r_da,tf_2DOF_r_da},'r due to da',leg_arr_r_da(2:4));
bode_general({tf_full_phi_da},'phi due to da',{'linear full model'});
bode_general({tf_full_psi_da},'psi due to da',{'linear full model'});

% due to dr 
bode_general({tf_full_beta_dr,tf_DR_beta_dr,tf_2DOF_beta_dr},'beta due to dr',leg_arr_beta(2:4));
bode_general({tf_full_p_dr,tf_DR_p_dr,tf_spiral_p_dr},'p due to dr',leg_arr_p_dr(2:4));
bode_general({tf_full_r_dr,tf_spiral_r_dr,tf_DR_r_dr,tf_2DOF_r_dr},'r due to dr',leg_arr_r_dr(2:5));
bode_general({tf_full_phi_dr,tf_spiral_phi_dr},'phi due to dr',leg_arr_phi(2:3));
bode_general({tf_full_psi_dr},'psi due to dr',{'linear full model'});

% root locus 

% due to da 
root_lat_plot({tf_full_beta_da,tf_DR_beta_da,tf_2DOF_beta_da},[1 1 0 1 0],'beta','da')
root_lat_plot({tf_full_p_da,tf_DR_p_da,tf_1DOF_p_da}, [1 1 0 0 1] ,'p','da')
root_lat_plot({tf_full_r_da,tf_DR_r_da,tf_2DOF_r_da}, [1 1 0 1 0] ,'r' ,'da')
root_lat_plot({tf_full_phi_da}, [1 0 0 0 0]  ,'phi' , 'da')
root_lat_plot({tf_full_psi_da}, [1 0 0 0 0]  ,'psi' , 'da')

% due to dr 
root_lat_plot({tf_full_beta_dr,tf_DR_beta_dr,tf_2DOF_beta_dr}, [1 1 0 1 0] ,'beta' , 'dr')
root_lat_plot({tf_full_p_dr,tf_DR_p_dr,tf_spiral_p_dr}, [1 1 1 0 0] ,'p', 'dr')
root_lat_plot({tf_full_r_dr , tf_DR_r_dr , tf_spiral_r_dr , tf_2DOF_r_dr}, [1 1 1 1 0] , 'r','dr')
root_lat_plot({tf_full_phi_dr,tf_spiral_phi_dr}, [1 0 1 0 0] ,'phi','dr')
root_lat_plot({tf_full_psi_dr}, [1 0 0 0 0] ,'psi','dr')
