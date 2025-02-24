clc;
clearvars;

%% ================= SYSTEM PARAMETERS =================
F = [2;8;3];  % External force vector (N)
M = [14;20;7]; % External moment vector (Nm)
I = [1, -2, -1; -2, 5, -4; -1, -4, 0.2]; % Inertia Matrix (kg*m^2)
m = 11; % Mass (kg)

%% ================= SIMULATION PARAMETERS =================
t0 = 0;   % Initial time (s)
tf = 25;  % Final time (s)
n = 20000; % Number of time steps
dt = (tf - t0) / (n - 1); % Time step size
timespan = t0:dt:tf; % Time vector

%% ================= INITIAL CONDITIONS =================
% State vector: [u, v, w, p, q, r, phi, theta, psi, x, y, z]
States_initial = [10; 2; 0; 2*pi/180; pi/180; 0; ...
                  20*pi/180; 15*pi/180; 30*pi/180; 2; 4; 7];

% Extract individual initial states for clarity
u_0 = States_initial(1);   v_0 = States_initial(2);   w_0 = States_initial(3);
p_0 = States_initial(4);   q_0 = States_initial(5);   r_0 = States_initial(6);
phi_0 = States_initial(7); theta_0 = States_initial(8); epsi_0 = States_initial(9);
x_0 = States_initial(10);  y_0 = States_initial(11);  z_0 = States_initial(12);

%% ================= SOLVE USING RUNGE-KUTTA 4 =================
States_dot_fn = @get_states_dot;
[t_vec_kutta, states_vec_kutta] = RK4(States_dot_fn, timespan, States_initial);

%% ================= SOLVE USING SIMULINK =================
sim('sim_6_dof.slx');
y_vec_simulink = [uvw_out, anglerates_out, angles_out, xyz_out];

%% ================= PLOT RESULTS =================
plotStateComparisons(t_vec_kutta, states_vec_kutta, tout, y_vec_simulink);

%% ================= ERROR ANALYSIS =================
[abs_error, rmse, max_error] = compare_errors(t_vec_kutta, states_vec_kutta, tout', y_vec_simulink');
