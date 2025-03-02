function plotStateComparisons(t_vec_kutta, states_vec_kutta, t_vec_simulink, y_vec_simulink)
    % Define state labels in LaTeX format and filenames
    state_labels_latex = {'u', 'v', 'w', 'p', 'q', 'r', '\phi', '\theta', '\psi', 'x', 'y', 'z', '\alpha', '\beta'}; 
    state_labels_filename = {'u', 'v', 'w', 'p', 'q', 'r', 'phi', 'theta', 'psi', 'x', 'y', 'z', 'alpha', 'beta'};

    % Define colors and line styles
    rk4_style = {'r-', 'LineWidth', 1.5};     % Red solid line for RK4
    simulink_style = {'b--', 'LineWidth', 1.5};  % Blue dashed line for Simulink

    % Create a single figure
    figure;
    set(gcf, 'Position', [100, 100, 1200, 800]); % Adjust figure size

    % Loop through all 14 states
    for i = 1:14
        subplot(5, 3, i); % Arrange in a 5x3 grid

        % Plot RK4 and Simulink solutions
        plot(t_vec_kutta, states_vec_kutta(i, :), rk4_style{:}); hold on;
        plot(t_vec_simulink, y_vec_simulink(i).Data, simulink_style{:});

        % Set labels with LaTeX
        ylabel(['$', state_labels_latex{i}, '$'], 'Interpreter', 'latex', 'FontSize', 10);

        % Show x-axis label only for bottom row
        if i >= 12
            xlabel('$t$ (time)', 'Interpreter', 'latex', 'FontSize', 10);
        end

        % Add legend only for the first subplot to save space
        if i == 1
            legend({'RK4', 'Simulink'}, 'Interpreter', 'latex', 'FontSize', 8, 'Location', 'Best');
        end

        grid on;
        set(gca, 'FontSize', 10, 'LineWidth', 1.2, 'Box', 'on');
    end

    % Add a single main title
    sgtitle('State Comparisons: RK4 vs Simulink', 'Interpreter', 'latex', 'FontSize', 14);

    % Save the figure as an SVG file
    saveas(gcf, 'state_comparisons.svg', 'svg');
end
