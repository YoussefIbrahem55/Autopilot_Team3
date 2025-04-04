function plotStateComparisons(t_vec_kutta, states_vec_kutta, t_vec_simulink, y_vec_simulink, dc)
% PLOTSTATECOMPARISONS Plots state comparisons between RK4 and Simulink results.
% This function generates a 3D trajectory plot and individual state comparison plots.
% It also saves the figures as SVG files.

%% Define state labels (LaTeX format and filenames)
state_labels_latex = {'u (ft/s)','v (ft/s)','w (ft/s)', '\beta (deg)', '\alpha (deg)', 'p (deg/s)', 'q (deg/s)', 'r (deg/s)', ...
                       '\phi (deg)', '\theta (deg)', '\psi (deg)', 'x (ft)', 'y (ft)', 'z (ft)'};
state_labels_filename = {'u','v','w', 'beta', 'alpha', 'p', 'q', 'r', 'phi', 'theta', 'psi', 'x', 'y', 'z'};
dc=dc*180/pi;
%% Define plot styles
rk4_style = {'r-', 'LineWidth', 1.5};     % Red solid line for RK4
simulink_style = {'b--', 'LineWidth', 1.5};  % Blue dashed line for Simulink

%% Plot 3D Trajectory Comparison
figure;
plot3(states_vec_kutta(12, :), states_vec_kutta(13, :), states_vec_kutta(14, :), rk4_style{:}); hold on;
plot3(y_vec_simulink(:, 12), y_vec_simulink(:, 13), y_vec_simulink(:, 14), simulink_style{:});
legend({'RK4', 'Benchmark'}, 'Interpreter', 'latex', 'FontSize', 8, 'Location', 'Best');
grid on;
set(gca, 'FontSize', 10, 'LineWidth', 1.2, 'Box', 'on');

% Create a title string with control inputs
inputTitle = sprintf('\\delta_a = %.0f^\\circ, \\quad \\delta_r = %.0f^\\circ, \\quad \\delta_e = %.0f^\\circ, \\quad \\delta_{th} = %.0f', ...
    dc(1), dc(2), dc(3), dc(4)*pi/180);
sgtitle(['At Input: ', '$$', inputTitle, '$$'], 'Interpreter', 'latex');

% Save the trajectory plot as an SVG file
% Convert control inputs to string format for filename
input_filename = sprintf('Traj_da_%d_dr_%d_de_%d_dth_%d.svg', ...
    round(dc(1)), round(dc(2)), round(dc(3)), round(dc(4)*pi/180));

% Save the trajectory plot with the generated filename
saveas(gcf, input_filename, 'svg');

%% Plot Individual State Comparisons
figure;
set(gcf, 'Position', [100, 100, 1200, 800]); % Adjust figure size

for i = 1:14
    subplot(4, 4, i); % Arrange plots in a 4x3 grid
    
    % Plot RK4 and Simulink data
    plot(t_vec_kutta, states_vec_kutta(i, :), rk4_style{:}); hold on;
    plot(t_vec_simulink, y_vec_simulink(:, i), simulink_style{:});
    
 % Compute min and max values
    y_max = max([max(states_vec_kutta(i, :)), max(y_vec_simulink(:, i))]);
    y_min = min([min(states_vec_kutta(i, :)), min(y_vec_simulink(:, i))]);

    % Ensure limits are increasing and valid
    if y_max <= y_min
        y_max = y_min + 1;  % Add a small offset to avoid issues
    end

    % Set limits with margin
    ylim([y_min - 0.1 * abs(y_min), y_max + 0.1 * abs(y_max)]);
    % Set title and labels with LaTeX formatting
    title(['$', state_labels_latex{i}, '$'], 'Interpreter', 'latex', 'FontSize', 10);
    ylabel(['$', state_labels_latex{i}, '$'], 'Interpreter', 'latex', 'FontSize', 10);
    
    % Show x-axis label only for bottom row
    if i >= 10
        xlabel('$t$ (time)', 'Interpreter', 'latex', 'FontSize', 10);
    end
    
    % Add legend only for the first subplot
    if i == 1
        legend({'RK4', 'Benchmark'}, 'Interpreter', 'latex', 'FontSize', 8, 'Location', 'Best');
    end
    
    grid on;
    set(gca, 'FontSize', 10, 'LineWidth', 1.2, 'Box', 'on');
end

% Set the main title with LaTeX interpreter
sgtitle(['At Input: ', '$$', inputTitle, '$$'], 'Interpreter', 'latex');

% Convert control inputs to string format for filename
input_filename = sprintf('states_da_%d_dr_%d_de_%d_dth_%d.svg', ...
    round(dc(1)), round(dc(2)), round(dc(3)), round(dc(4)*pi/180));

% Save the trajectory plot with the generated filename
saveas(gcf, input_filename, 'svg');


end