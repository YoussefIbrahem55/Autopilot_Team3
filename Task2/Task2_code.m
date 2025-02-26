clc
clearvars

% Initial conditions

  

% Solution parameters
t0 =0 ; %Initial time
tf = 25; % End time
n = 20000;

F = [2;8;3] ;

M = [14;20;7] ;

I = [1,-2,-1;-2,5,-4;-1,-4,0.2];

m = 11;
% Number of intervals, high because of Hard-Nonlinearity
dt = (tf - t0) / (n-1); % Step size
timespan = t0:dt:tf  ;
States_initial = [10;2;0;2*pi/180;pi/180;0;20*pi/180;15*pi/180;30*pi/180;2;4;7];
%initial condition
u_0= States_initial(1)    ;v_0= States_initial(2)          ;w_0=States_initial(3);
p_0=States_initial(4)  ;q_0=States_initial(5)     ;r_0=States_initial(6);
phi_0=States_initial(7) ;theta_0=States_initial(8)   ;epsi_0=States_initial(9);
x_0=States_initial(10)      ;y_0=States_initial(11)           ;z_0=States_initial(12);

%states_vec = zeros(12,n+1);

States_dot_fn = @get_states_dot;
%-------Solving the ODE using Runge-Kutta Method--------%

[t_vec_kutta,states_vec_kutta] = RK4(States_dot_fn,timespan,States_initial) ;

%-----Solving the ODE using Matlab ode45 Built in function------%

% [t_vec_ode_45,y_vec_ode_45] = ode45(States_dot_fn,timespan,States_initial) ;
sim('sim_6_dof.slx')
y_vec_simulink=[uvw_out, anglerates_out, angles_out, xyz_out];

plotStateComparisons(t_vec_kutta, states_vec_kutta,tout, y_vec_simulink)


