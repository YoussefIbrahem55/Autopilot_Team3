function [abs_error, rmse, max_error] = compare_errors(t_rk4, y_rk4, t_ode45, y_ode45)
   
    % Compute Absolute Error
    abs_error = abs(y_rk4 - y_ode45);

    % Compute Mean Absolute Error (MAE) for each state separately
    mae = mean(abs_error, 2); % Mean across time steps (row-wise for each state)
    % Compute RMSE (for each state separately)
    rmse = sqrt(mean(abs_error.^2, 2)); % Row-wise RMSE (each row = one state)

    % Compute Max Error (for each state separately)
    max_error = max(abs_error, [], 2);  % Max across time steps

    % Display Results
    disp('Mean Absolute Error (MAE) for each state:');
    disp(mae);
    disp('Root Mean Square Error (RMSE) for each state:');
    disp(rmse);
    disp('Max Error for each state:');
    disp(max_error);
end
