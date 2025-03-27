clc;close all;

%% Read the derivatives and reference conditions
filename_density_L = 'JETSTAR_FC3.xlsx'; %%put here the location of your excel sheet

aircraft_data=xlsread(filename_density_L,'B2:B61');%% here B2:B61 means read the excel sheet from cell B2 to cell B61

%%in the next step we will read from the vector(aircraft_data) but take care of the order the values in excel sheet is arranged

% Time vector parameters
dt = aircraft_data(1);    tfinal = aircraft_data(2); lengths=tfinal/dt+1;
time_V = (0:dt:tfinal)';

% initial conditions
s0 = aircraft_data(4:15);
sdot0 = zeros(12,1);
w_dot0=0; 
Vto = sqrt(s0(1)^2 + s0(2)^2 + s0(3)^2);    % Vto

u0     = s0(1);
v0     = s0(2);
w0     = s0(3);

p0     = s0(4);
q0     = s0(5);
r0     = s0(6);

phi0   = s0(7);
theta0 = s0(8);
psi0   = s0(9);

x0     = s0(10);
y0     = s0(11);
z0     = s0(12);

alpha0 = theta0; 
beta0  = 0;



% control actions values
dc = [ aircraft_data(57:59) * pi/180 ; aircraft_data(60)]; %[da, dr, de, dth]

% gravity, mass % inertia
m = aircraft_data(51);
g = aircraft_data(52);
M_0 = [0; 0; 0];
Fg_0 = m*g*[sin(s0(8)); -cos(s0(8))*sin(s0(7)); -cos(s0(8))*cos(s0(7))];

rho = aircraft_data(52);
Ixx = aircraft_data(53);
Iyy = aircraft_data(54);
Izz = aircraft_data(55);
Ixz = aircraft_data(56);    Ixy=0;  Iyz=0;
I = [Ixx , -Ixy , -Ixz ;...
    -Ixy , Iyy , -Iyz ;...
    -Ixz , -Iyz , Izz];
invI=inv(I);

% stability derivatives Longitudinal motion
SD_Long = aircraft_data(21:36);
SD_Long_final = SD_Long;


% stability derivatives Lateral motion
SD_Lat_dash = aircraft_data(37:50);
run('LateralFunc.m');
SD_Lat_final = SD_Lat;

K = struct('u',s0(1),'v',s0(2),'w',s0(3),'p',s0(4),'q',s0(5),...
    'r',s0(6),'phi',s0(7),'theta',s0(8),'psi',s0(9),'x',s0(10),...
    'y',s0(11),'z',s0(12),'alpha',s0(8),'beta',0,'V_t',Vto,'w_dot',0);   % used in delay box in simulink as initial values to bus selector

%% Matrices

    Xu    = SD_Long_final(1);
    Xw    = SD_Long_final(4);
    Xde   = SD_Long_final(11);
    Xdth  = SD_Long_final(14);
    Zu    = SD_Long_final(2);
    Zw    = SD_Long_final(5);
    Zwd   = SD_Long_final(7);
    Zq    = SD_Long_final(8);
    Zde   = SD_Long_final(12);
    Zdth  = SD_Long_final(15);
    Mu    = SD_Long_final(3);
    Mw    = SD_Long_final(6);
    Mwd   = SD_Long_final(9);
    Mq    = SD_Long_final(10);
    Mde   = SD_Long_final(13);
    Mdth  = SD_Long_final(16);
    
    
    Yv  = SD_Lat_final(1); 
    Yp  = 0;
    Yr  = 0;
    Lv  = SD_Lat_final(2);
    Nv  = SD_Lat_final(3);
    Lp  = SD_Lat_final(4);
    Np  = SD_Lat_final(5);
    Lr  = SD_Lat_final(6);
    Nr  = SD_Lat_final(7);
    Yda = SD_Lat_final(8);
    Ydr = SD_Lat_final(9);
    Lda = SD_Lat_final(10);
    Nda = SD_Lat_final(11);
    Ldr = SD_Lat_final(12);
    Ndr = SD_Lat_final(13);
   
% delta_states : [d_u d_v d_w d_p d_q d_r d_wdot]

    Matrix_states = [Xu   0   Xw   0   0   0   0 
                     0    Yv  0    Yp  0   Yr  0
                     Zu   0   Zw   0   Zq  0   Zwd
                     0    Lv  0    Lp  0   Lr  0
                     Mu   0   Mw   0   Mq  0   Mwd
                     0    Nv  0    Np  0   Nr  0];

% delta_controls : [d_aileron d_rudder d_elevator d_thrust]

Matrix_Controllers = [0     0       Xde   Xdth 
                      Yda     Ydr    0      0     
                      0     0       Zde   Zdth 
                      Lda  Ldr    0      0     
                      0     0       Mde   Mdth 
                      Nda  Ndr    0      0    ];

