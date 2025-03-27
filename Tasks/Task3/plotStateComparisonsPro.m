function plotStateComparisonsPro(t_vec, states_data, state_labels_latex, plot_titles, legend_labels, dc)
% PLOTSTATECOMPARISONSPRO Plots state comparisons for multiple datasets.
% This function generates individual state comparison plots and saves the figures as SVG files.
%
% Inputs:
%   t_vec: Time vector (common for all datasets)
%   states_data: Cell array of state matrices (each matrix is of size [num_states x num_time_steps])
%   state_labels_latex: Cell array of state labels in LaTeX format
%   plot_titles: Struct containing title information (main title only)
%   legend_labels: Cell array of legend labels for each dataset
%   input_vector: Vector of input parameters (e.g., [da, dr, de, dth])

%% Validate inputs
dc=dc*180/pi;
dc(4)=dc(4)*pi/180;
num_datasets = length(states_data);
num_states = length(state_labels_latex);
     words = strsplit(plot_titles, ' '); % Split mode name into words
        firstLetters = cellfun(@(w) w(1), words, 'UniformOutput', false); % Extract first letter of each word
        shortModeName = strjoin(firstLetters, ''); % Join letters into a single string
      

if num_datasets ~= length(legend_labels)
    error('Mismatch in number of datasets or legend labels.');
end

%% Generate random plot styles for each dataset
plot_styles = cell(1, num_datasets);
line_styles = {'-', '--', ':', '-.'}; % Line styles
colors = lines(num_datasets); % Use MATLAB's 'lines' colormap for distinct colors

for j = 1:num_datasets
    % Randomly select a line style, marker, and color
    line_style = line_styles{randi(length(line_styles))};
    color = colors(j, :); % Use a unique color for each dataset
    
    % Combine into a plot style
    plot_styles{j} = {'LineStyle', line_style, 'Color', color,'LineWidth',2};
end

%% Generate save filename based on title and input vector
% Extract relevant information from plot_titles
main_title = plot_titles;

% Define abbreviations for input vector components
abbreviations = {'da', 'dr', 'de', 'dth'}; % Example: de = delta_elevator, dr = delta_rudder, etc.

% Find the non-zero input and its index
non_zero_index = find(dc ~= 0); % Find indices of non-zero inputs
if ~isempty(non_zero_index)
    % Assume only one non-zero input (as per your description)
    non_zero_input = abbreviations{non_zero_index}; % Get the abbreviation
    non_zero_value = dc(non_zero_index); % Get the value
    input_str = sprintf('%s%.1f', non_zero_input, non_zero_value); % Format as "namevalue"
else
    input_str = ''; % If all inputs are zero
end

% Combine the main title and input vector into a single filename
save_filename = sprintf('%s-%s', shortModeName, input_str);

% Replace spaces and special characters with underscores
%% Plot Individual State Comparisons
figure;
set(gcf, 'Position', [100, 100, 1200, 800]); % Adjust figure size

% Dynamically calculate the number of rows and columns for subplots
num_rows = ceil(sqrt(num_states)); % Number of rows
num_cols = ceil(num_states / num_rows); % Number of columns

for i = 1:num_states
    subplot(num_rows, num_cols, i); % Arrange plots dynamically
    
    % Plot each dataset
    for j = 1:num_datasets
        plot(t_vec, states_data{j}(i, :), plot_styles{j}{:}); hold on;
    end
    
    % Compute min and max values for y-axis limits
    y_max = max(cellfun(@(x) max(x(i, :)), states_data));
    y_min = min(cellfun(@(x) min(x(i, :)), states_data));

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

    if i > (num_rows - 1) * num_cols % Bottom 
        
        xlabel('$t$ (time)', 'Interpreter', 'latex', 'FontSize', 10);
    end
    
    % Add legend only for the first subplot
    if i == 1
        legend(legend_labels, 'Interpreter', 'latex', 'FontSize', 8, 'Location', 'Best');
    end
    
    grid on;
    set(gca, 'FontSize', 10, 'LineWidth', 1.2, 'Box', 'on');
end

inputTitle = sprintf('\\delta_a = %.0f^\\circ, \\quad \\delta_r = %.0f^\\circ, \\quad \\delta_e = %.0f^\\circ, \\quad \\delta_{th} = %.0f', ...
    dc(1), dc(2), dc(3), dc(4));
sgtitle({main_title,['At Input: ', '$$', inputTitle, '$$']}, 'Interpreter', 'latex');
% Save the plot as an SVG file
export_fig ([save_filename, '.pdf'], '-pdf', '-r600', '-transparent','-nocrop');

close all;

end