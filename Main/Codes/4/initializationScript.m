% The aerodynamic forces and moments can be expressed as a function of all the motion variables [Nelson] page 63

%% Step 1: Clear workspace and close figures
clc;
clear all;
close all;

%% Step 2: Load Excel Sheet Data
filename_density_L = 'JetstarFC3';  % Specify the location of your Excel sheet
aircraft_data = xlsread(filename_density_L, 'B2:B61');  % Read data from Excel (B2:B61)
state_labels_latex = {'u (ft/s)', 'v (ft/s)', 'w (ft/s)', '\beta (deg)', '\alpha (deg)', ...
    'p (deg/s)', 'q (deg/s)', 'r (deg/s)', '\phi (deg)', '\theta (deg)', '\psi (deg)', 'x (ft)', 'y (ft)', 'z (ft)'};
state_labels_filename = {'u', 'v', 'w', '\beta', '\alpha', 'p', 'q', 'r', '\phi', '\theta', '\psi', 'x', 'y', 'z'};
input_labels_latex = {'\delta_a', '\delta_r', '\delta_e', '\delta_{th}'};

%% Step 3: Extract Time Vector Parameters
dt = aircraft_data(1);           % Time step
tfinal = aircraft_data(2);       % Final time
lengths = tfinal/dt + 1;         % Total number of time steps
time_V = (0:dt:tfinal)';         % Time vector

%% Step 4: Extract Initial Conditions
s0 = aircraft_data(4:15);         % Initial state variables
wdot0 = 0;                        % Initial angular acceleration
sdot0 = zeros(12,1);              % Zero initial state derivatives
Vto = sqrt(s0(1)^2 + s0(2)^2 + s0(3)^2);  % Initial velocity magnitude
initial_conditions = [aircraft_data(13:15)' aircraft_data(10:12)' aircraft_data(4:6)' aircraft_data(7:9)' aircraft_data(18) aircraft_data(20) Vto 0];
    %% Step 6: Define Gravity, Mass, and Inertia Parameters
    m = aircraft_data(51);   % Mass
    g = aircraft_data(52);   % Gravity acceleration
    Ixx = aircraft_data(53);
    Iyy = aircraft_data(54);
    Izz = aircraft_data(55);
    Ixz = aircraft_data(56);
    Ixy = 0;
    Iyz = 0;
    I = [Ixx, -Ixy, -Ixz;
         -Ixy, Iyy, -Iyz;
         -Ixz, -Iyz, Izz];   % Inertia matrix
    invI = inv(I);           % Inverse of inertia matrix

    % Initial gravity force
    F_gravity_0 = m*g * [ sin(s0(8));
                         -cos(s0(8))*sin(s0(7));
                         -cos(s0(8))*cos(s0(7)) ];
    M0 = [0; 0; 0];

    %% Step 7: Load Stability Derivatives
    % Longitudinal Motion Derivatives
    SD_Long = aircraft_data(21:36);
    SD_Long_final = SD_Long;

    % Lateral Motion Derivatives
    SD_Lat_dash = aircraft_data(37:50);
    run('LateralFuncc');  % Run lateral derivatives transformation script
    SD_Lat_final = SD_Lat;

