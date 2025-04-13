function export_system_analysis(sys, modeName, stateNames, inputNames)
syms s;

% Loop through states and inputs,
for i = 1:size(sys.B, 2)  % Loop over inputs
    for j = 1:size(sys.C, 1)  % Loop over states
        % Extract the transfer function and simplify it
        G_ij = minreal(tf(sys(j, i)), 0.001);
        
        words = strsplit(modeName, ' '); % Split mode name into words
        firstLetters = cellfun(@(w) w(1), words, 'UniformOutput', false); % Extract first letter of each word
        shortModeName = strjoin(firstLetters, ''); % Join letters into a single string
        % Convert to symbolic form for LaTeX export
        [num, den] = tfdata(G_ij, 'v');
        num_sym = poly2sym(num, s);
        den_sym = poly2sym(den, s);
        tf_sym = simplify(num_sym / den_sym);
        tf_sym = vpa(tf_sym, 4); % Reduce precision
        latex_tf = latex(tf_sym);
        
        % Create a clean filename by replacing "\" with "_"
        cleanState = strrep(stateNames{j}, '\', '-');
        cleanInput = strrep(inputNames{i}, '\', '-');
        cleanInput = strrep(cleanInput, '{', '');
        cleanInput = strrep(cleanInput, '}', '');
        cleanInput = strrep(cleanInput, '_', '-');
        
        % Save LaTeX transfer function
        filename = sprintf('%s-tf-%s-%s.txt', shortModeName, cleanState, cleanInput);
        fileID = fopen(filename, 'w');
        fprintf(fileID, '%s\n', latex_tf);
        fclose(fileID);
        
        % Format the LaTeX fraction for the plot title
        latex_title = sprintf('$$\\frac{%s}{%s}$$', stateNames{j}, inputNames{i});
        
        % Plot Bode and Root Locus, save as SVG
        fig_bode = figure;
        bode(G_ij);
        grid on;
        title(['Bode Plot: ', latex_title], 'Interpreter', 'latex');
        %saveas(fig_bode, sprintf('%s_bode_%s_%s.svg', shortModeName, cleanState, cleanInput));
        print(fig_bode, sprintf('%s-bode-%s-%s.pdf', shortModeName, cleanState, cleanInput), '-dpdf', '-fillpage');

        fig_rlocus = figure;
        rlocus(G_ij);
        grid on;
        title(['Root Locus: ', latex_title], 'Interpreter', 'latex');
        %saveas(fig_rlocus, sprintf('%s_rlocus_%s_%s.svg', shortModeName, cleanState, cleanInput));
        print(fig_rlocus, sprintf('%s-rlocus-%s-%s.pdf', shortModeName, cleanState, cleanInput), '-dpdf', '-fillpage');

        close(fig_bode);
        close(fig_rlocus);
    end
end
end
