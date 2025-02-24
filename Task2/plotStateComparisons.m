function plotStateComparisons(t_vec_kutta, states_vec_kutta, t_vec_ode_45, y_vec_ode_45)
    % Define state labels in lowercase (LaTeX format) and filenames
    state_labels_latex = {'u', 'v', 'w', 'p', 'q', 'r', '\phi', '\theta', '\psi', 'x', 'y', 'z'}; 
    state_labels_filename = {'u', 'v', 'w', 'p', 'q', 'r', 'phi', 'theta', 'psi', 'x', 'y', 'z'};

    % Define colors and line styles
    rk4_style = {'r-', 'LineWidth', 2};     % Red solid line for RK4
    ode45_style = {'b--', 'LineWidth', 2};  % Blue dashed line for ode45

    % Loop through all 12 states
    for i = 1:12
        figure;

        % Plot RK4 and ode45 solutions
        plot(t_vec_kutta, states_vec_kutta(i, :), rk4_style{:}); hold on;
        plot(t_vec_ode_45, y_vec_ode_45(:, i), ode45_style{:});

        % Set labels with LaTeX in lowercase
        xlabel('$t$ (time)', 'Interpreter', 'latex', 'FontSize', 14);
        ylabel(['$', state_labels_latex{i}, '$'], 'Interpreter', 'latex', 'FontSize', 14);
        title(['solution of $', state_labels_latex{i}, '(t)$'], 'Interpreter', 'latex', 'FontSize', 16);

        % Add legend
        legend({['$', state_labels_latex{i}, '(t)$ using rk4'], ...
                ['$', state_labels_latex{i}, '(t)$ using ode4(SIMULINK)']}, ...
                'Interpreter', 'latex', 'FontSize', 12, 'Location', 'Best');

        % Beautify grid and axis
        grid on;
        set(gca, 'FontSize', 12, 'LineWidth', 1.2, 'Box', 'on');

        % Save the figure as an SVG file with lowercase names
        filename = sprintf('solution_%s.svg', state_labels_filename{i});
        saveas(gcf, filename, 'svg');

        hold off;
    end
end
