clc
clearvars

% Initial conditions
t0 = 0;
Y0 = [2; 1]; 

% Solution parameters
tf = 20; % End time
n = 100; % Number of intervals
dt = (tf - t0) / n; % Step size
timespan = linspace(t0, tf, n+1); 
Y_vec = zeros(2,n+1) ;
Y_vec(:,1) = Y0 ; 

%Derivatives equation
f_vec = @(t,Y_vec) [sin(t) + cos(Y_vec(1)) + cos(Y_vec(2)) ; sin(t) + sin(Y_vec(2))];


%-------Solving the ODE using Runge-Kutta Method--------%

[t_vec_kutta,y_vec_kutta] = RK4(f_vec,timespan,Y0) ;

%-----Solving the ODE using Matlab ode45 Built in function------%

[t_vec_ode_45,y_vec_ode_45] = ode45(f_vec,timespan,Y0) ;


figure;
subplot(1,2,1);
plot(t_vec_kutta, y_vec_kutta(1,:), 'r', 'LineWidth', 1.5); hold on;
plot(t_vec_ode_45, y_vec_ode_45(:,1), 'b', 'LineWidth', 1.5); hold on;
xlabel('t');
ylabel('y');
title('Solution of Y(1)');
legend('y1(t) using RK4 Method ', 'y1(t) Using Matlab ode45 function');
grid on;
hold off;

subplot(1,2,2)
plot(t_vec_kutta, y_vec_kutta(2,:), 'r', 'LineWidth', 1.5);hold on;
plot(t_vec_ode_45, y_vec_ode_45(:,2), 'b', 'LineWidth', 1.5);
xlabel('t');
ylabel('y');
title('Solution of  Y(2)');
legend('y2(t) using RK4 Method ', 'y2(t) Using Matlab ode45 function');
grid on;
hold off;



ERROR_1 = mean(abs((y_vec_kutta(1,:).'-y_vec_ode_45(:,1))./y_vec_ode_45(:,1)))*100 

ERROR_2 = mean(abs((y_vec_kutta(2,:).'-y_vec_ode_45(:,2))./y_vec_ode_45(:,2)))*100 