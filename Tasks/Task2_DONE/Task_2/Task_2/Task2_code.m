clc
clearvars

% Initial conditions

  

% Solution parameters
t0 =0 ; %Initial time
tf = 25; % End time
n = 10000; % Number of intervals
dt = (tf - t0) / n; % Step size
timespan = linspace(t0,tf,n+1)  ;
States_initial = [10;2;0;2*pi/180;pi/180;0;20*pi/180;15*pi/180;30*pi/180;2;4;7];

%states_vec = zeros(12,n+1);

States_dot_fn = @get_states_dot;
%-------Solving the ODE using Runge-Kutta Method--------%

[t_vec_kutta,states_vec_kutta] = RK4(States_dot_fn,timespan,States_initial) ;

%-----Solving the ODE using Matlab ode45 Built in function------%

[t_vec_ode_45,y_vec_ode_45] = ode45(States_dot_fn,timespan,States_initial) ;


figure;

plot(t_vec_kutta, states_vec_kutta(1,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,1), 'b'); hold on;
xlabel('t');
ylabel('U');
title('Solution of U(t)');
legend('U(t) using RK4 Method ', 'U(t) Using Matlab ode45 function');
grid on;
hold off;
%
figure;
plot(t_vec_kutta, states_vec_kutta(2,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,2), 'b'); hold on;
xlabel('t');
ylabel('V');
title('Solution of V(t)');
legend('V(t) using RK4 Method ', 'V(t) Using Matlab ode45 function');
grid on;
hold off;


figure;
plot(t_vec_kutta, states_vec_kutta(3,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,3), 'b'); hold on;
xlabel('t');
ylabel('W');
title('Solution of W(t)');
legend('W(t) using RK4 Method ', 'W(t) Using Matlab ode45 function');
grid on;
hold off;


figure;
plot(t_vec_kutta, states_vec_kutta(4,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,4), 'b'); hold on;
xlabel('t');
ylabel('P');
title('Solution of P(t)');
legend('V(t) using RK4 Method ', 'P(t) Using Matlab ode45 function');
grid on;
hold off;


figure;
plot(t_vec_kutta, states_vec_kutta(5,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,5), 'b'); hold on;
xlabel('t');
ylabel('Q');
title('Solution of Q(t)');
legend('Q(t) using RK4 Method ', 'Q(t) Using Matlab ode45 function');
grid on;
hold off;


figure;
plot(t_vec_kutta, states_vec_kutta(6,:), 'r'); hold on;
plot(t_vec_ode_45, y_vec_ode_45(:,6), 'b'); hold on;
xlabel('t');
ylabel('R');
title('Solution of R(t)');
legend('R(t) using RK4 Method ', 'R(t) Using Matlab ode45 function');
grid on;
hold off;


figure;
plot(t_vec_kutta, states_vec_kutta(7,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,7), 'b'); hold on;
xlabel('t');
ylabel('phi');
title('Solution of phi(t)');
legend('phi(t) using RK4 Method ', 'phi(t) Using Matlab ode45 function');
grid on;
hold off;


figure;
plot(t_vec_kutta, states_vec_kutta(8,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,8), 'b'); hold on;
xlabel('t');
ylabel('ceta');
title('Solution of ceta(t)');
legend('ceta(t) using RK4 Method ', 'ceta(t) Using Matlab ode45 function');
grid on;
hold off;

figure;
plot(t_vec_kutta, states_vec_kutta(9,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,9), 'b'); hold on;
xlabel('t');
ylabel('psi');
title('Solution of psi(t)');
legend('psi(t) using RK4 Method ', 'psi(t) Using Matlab ode45 function');
grid on;
hold off;


figure;
plot(t_vec_kutta, states_vec_kutta(10,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,10), 'b'); hold on;
xlabel('t');
ylabel('X');
title('Solution of X(t)');
legend('X(t) using RK4 Method ', 'X(t) Using Matlab ode45 function');
grid on;
hold off;

figure;
plot(t_vec_kutta, states_vec_kutta(11,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,11), 'b'); hold on;
xlabel('t');
ylabel('Y');
title('Solution of Y(t)');
legend('Y(t) using RK4 Method ', 'Y(t) Using Matlab ode45 function');
grid on;
hold off;


figure;
plot(t_vec_kutta, states_vec_kutta(12,:), 'r'); hold on;

plot(t_vec_ode_45, y_vec_ode_45(:,12), 'b'); hold on;
xlabel('t');
ylabel('Z');
title('Solution of Z(t)');
legend('Z(t) using RK4 Method ', 'Z(t) Using Matlab ode45 function');
grid on;
hold off;
