function export_system_comparison(systemsTable, stateNames, inputNames)
    % systemsTable should be a table with columns:
    %   - sys: the system
    %   - modeName: display name for the system
    %   - lineSpec: line specification for plotting (e.g., 'b-', 'r--')
    
    syms s;
    numSystems = height(systemsTable);
    
    if numSystems ~= 2
        error('This function currently only supports comparing exactly 2 systems');
    end
    
    % Get the two systems
    sys1 = systemsTable.sys{1};
    sys2 = systemsTable.sys{2};
    
    
    % Verify systems have same dimensions
    if ~isequal(size(sys1.B), size(sys2.B)) || ~isequal(size(sys1.C), size(sys2.C))
        error('Systems must have the same dimensions');
    end
    
    for i = 1:size(sys1.B, 2)  % Loop over inputs
        for j = 1:size(sys1.C, 1)  % Loop over states
            % Get transfer functions for both systems
            G1_ij = minreal(tf(sys1(j, i)), 0.001);
            G2_ij = minreal(tf(sys2(j, i)), 0.001);
            
            % Create clean names for filenames
            cleanState = sanitizeFilename(stateNames{j});
            cleanInput = sanitizeFilename(inputNames{i});
            
            % Generate comparative plots
            plotComparativeBode(G1_ij, G2_ij, systemsTable, ...
                               stateNames{j}, inputNames{i}, cleanState, cleanInput);
            
            plotComparativeRootLocus(G1_ij, G2_ij, systemsTable, ...
                                   stateNames{j}, inputNames{i}, cleanState, cleanInput);
        end
    end
end

%% Helper functions
function shortName = createShortName(modeName)
    words = strsplit(modeName, ' ');
    firstLetters = cellfun(@(w) w(1), words, 'UniformOutput', false);
    shortName = strjoin(firstLetters, '');
end

function cleanStr = sanitizeFilename(str)
    cleanStr = strrep(str, '\', '-');
    cleanStr = strrep(cleanStr, '{', '');
    cleanStr = strrep(cleanStr, '}', '');
    cleanStr = strrep(cleanStr, '_', '-');
    cleanStr = regexprep(cleanStr, '[^a-zA-Z0-9-]', '');
end

function tf_text = getLatexTF(G)
    [num, den] = tfdata(G, 'v');
    num_str = poly2str(num, 's');
    den_str = poly2str(den, 's');
    tf_text = ['$\frac{', num_str, '}{', den_str, '}$'];
end

function str = poly2str(p, var)
    terms = {};
    for k = 1:length(p)
        power = length(p) - k;
        coeff = p(k);
        
        if coeff == 0
            continue
        elseif power == 0
            terms{end+1} = sprintf('%g', coeff);
        else
            if coeff == 1
                coeff_str = '';
            elseif coeff == -1
                coeff_str = '-';
            else
                coeff_str = sprintf('%g', coeff);
            end
            
            if power == 1
                terms{end+1} = [coeff_str, var];
            else
                terms{end+1} = [coeff_str, var, '^', num2str(power)];
            end
        end
    end
    
    if isempty(terms)
        str = '0';
    else
        str = strjoin(terms, ' + ');
        str = strrep(str, '+ -', '- ');
    end
end

function plotComparativeBode(G1, G2, systemsTable, stateName, inputName, cleanState, cleanInput)
    fig = figure('Position', [100, 100, 800, 600]);
    
    % Get frequency response data
    [mag1, phase1, w1] = bode(G1);
    [mag2, phase2, w2] = bode(G2);
    
    % Convert to dB and degrees
    mag1dB = 20*log10(squeeze(mag1));
    phase1 = squeeze(phase1);
    mag2dB = 20*log10(squeeze(mag2));
    phase2 = squeeze(phase2);
    
    % Create magnitude plot
    subplot(2,1,1);
    semilogx(w1, mag1dB, systemsTable.lineSpec{1}, 'LineWidth', 1.5, 'DisplayName', systemsTable.modeName{1});
    hold on;
    semilogx(w2, mag2dB, systemsTable.lineSpec{2}, 'LineWidth', 1.5, 'DisplayName', systemsTable.modeName{2});
    grid on;
    ylabel('Magnitude (dB)');
    legend('Location', 'best');
    title(sprintf('Bode Magnitude: $$\\frac{%s}{%s}$$', stateName, inputName), 'Interpreter', 'latex');
    
    % Create phase plot
    subplot(2,1,2);
    semilogx(w1, phase1, systemsTable.lineSpec{1}, 'LineWidth', 1.5, 'DisplayName', systemsTable.modeName{1});
    hold on;
    semilogx(w2, phase2, systemsTable.lineSpec{2}, 'LineWidth', 1.5, 'DisplayName', systemsTable.modeName{2});
    grid on;
    ylabel('Phase (deg)');
    xlabel('Frequency (rad/s)');
    title(sprintf('Bode Phase: $$\\frac{%s}{%s}$$', stateName, inputName), 'Interpreter', 'latex');
    
    % Adjust layout
    sgtitle(sprintf('%s vs %s', systemsTable.modeName{1}, systemsTable.modeName{2}), 'FontWeight', 'bold');
    
    % Save plot
    filename = sprintf('compare-bode-%s-vs-%s-%s-%s.pdf', ...
                      createShortName(systemsTable.modeName{1}), ...
                      createShortName(systemsTable.modeName{2}), ...
                      cleanState, cleanInput);
   export_fig (filename, '-pdf', '-r600', '-nocrop', '-transparent');

    close(fig);
end

function plotComparativeRootLocus(G1, G2, systemsTable, stateName, inputName, cleanState, cleanInput)
    fig = figure('Position', [100, 100, 1000, 500]);
    
    % Get transfer function strings
    tf1_text = getLatexTF(G1);
    tf2_text = getLatexTF(G2);
    
    % Root locus for system 1
    subplot(1,2,1);
    rlocus(G1);
    grid on;
    title({systemsTable.modeName{1}; tf1_text}, 'Interpreter', 'latex');
    
    % Root locus for system 2
    subplot(1,2,2);
    rlocus(G2);
    grid on;
    title({systemsTable.modeName{2}; tf2_text}, 'Interpreter', 'latex');
    
    % Add overall title
    sgtitle(sprintf(' $$\\frac{%s}{%s}$$', stateName, inputName), ...
           'Interpreter', 'latex', 'FontWeight', 'bold');
    
    % Save plot
    filename = sprintf('compare-rlocus-%s-vs-%s-%s-%s.pdf', ...
                      createShortName(systemsTable.modeName{1}), ...
                      createShortName(systemsTable.modeName{2}), ...
                      cleanState, cleanInput);
                  
    export_fig (filename, '-pdf', '-r600', '-nocrop', '-transparent');

    close(fig);
end