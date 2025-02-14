
clc
clearvars

% Initial conditions
t0 = 0;
Y0 = [2; 1]; 

% Solution parameters
tf = 20; % End time
n = 100; % Number of intervals
dt = (tf - t0) / n; % Step size

% Arrays to store results
timespan = linspace(t0, tf, n+1);
Y_array = zeros(2, n+1); % State array [y1; y2]
Y_array(:, 1) = Y0; % Set initial conditions


%-------Solving the ODE using Euler Method--------%

% Euler Iteration
for i = 1:n
    t = timespan(i);
    Y = Y_array(:, i);

    % Compute the derivative
    y1=Y_array(1,i);
    y2=Y_array(2,i);
    dy1dt = sin(t) + cos(y1) + cos(y2);
    dy2dt = sin(t) + sin(y2);
    dYdt = [dy1dt; dy2dt];


    % Update the state vector
    Y_new = Y + dt * dYdt;
    Y_array(:, i+1) = Y_new;
end

% Extract results
y1_values = Y_array(1, :);
y2_values = Y_array(2, :);


%Plot the results
figure;
subplot(1,2,1);
plot(timespan, y1_values, 'b', 'LineWidth', 1.5); hold on;
plot(timespan, y2_values, 'r', 'LineWidth', 1.5);
xlabel('t');
ylabel('y');
title('Solution of the ODE System using Euler Method');
legend('y1(t)', 'y2(t)');
grid on;
hold off;



%-----Solving the ODE using Matlab ode45 Built in function------%


function dydt = odefcn(t,y)
dydt =zeros(2,1) ;
dydt(1) = sin(t) + cos(y(1)) + cos(y(2)); %dy1/dt
dydt(2) = sin(t) + sin(y(2));           %dy2/dt
end

[t,y] = ode45(@(t,y)odefcn(t,y), timespan,Y0);

%Plot the results
subplot(1,2,2)
plot(t, y(:,1), 'b', 'LineWidth', 1.5); hold on;
plot(t, y(:,2), 'r', 'LineWidth', 1.5);
xlabel('t');
ylabel('y');
title('Solution of the ODE System using Ode45 function');
legend('y1(t)', 'y2(t)');
grid on;
hold off;

a=y1_values.';


ERROR_1 = mean(abs((y1_values.'-y(:,1))./y(:,1)))*100 

ERROR_2 = mean(abs((y2_values.'-y(:,2))./y(:,2)))*100