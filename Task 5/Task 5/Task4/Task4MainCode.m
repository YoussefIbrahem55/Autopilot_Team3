initializationScript;

%% ====================== CONTROL INPUT DEFINITION ======================
long_or_lat =1  ;  % put "1" if longitudinal mode
if long_or_lat == 1
    N = 5;
else
    N = 8;
end

for k = 1:N
    dc = [aircraft_data(57:59)*pi/180; aircraft_data(60)];  % Control surface deflections
    
    % Longitudinal control inputs
    if long_or_lat == 1
        da = 0;            % dc(1);
        dr = 0;            % dc(2);
        de = [1, 5, 25, 0, 0];   % dc(3);
        dth = [0, 0, 0, 2000, 10000];  % dc(4);
        dc = [da, dr, de(k), dth(k)*180/pi]*pi/180;
        de = de(k)*pi/180;
        dth = dth(k);
        % Lateral control inputs
    else
        da = [1, 5, 10, 25, 0, 0, 0, 0];  % dc(1);
        dr = [0, 0, 0, 0, 1, 5, 10, 25];   % dc(2);
        de = 0;                           % dc(3);
        dth = 0;                          % dc(4);
        dc = [da(k), dr(k), de, dth*180/pi]*pi/180;
        da = da(k)*pi/180;
        dr = dr(k)*pi/180;
    end
    
    %% ====================== EQUATIONS OF MOTION SOLUTION (RK4) ======================
    states(:,1) = s0;
    for i = 1:lengths
        if i == 1
            wdot = wdot0;
        end
        
        % Compute Forces and Moments
        [F, M, Matrix_states, Matrix_Controls] = afModel(SD_Long_final, SD_Lat_final, [states(:,i); wdot], [s0; wdot0], dc, m, g, I);
        
        % Runge-Kutta 4th Order Method (RK4)
        K_1 = get_states_dot(time_V(i), states(:,i), F, M, I, m);
        K_2 = get_states_dot(time_V(i) + dt/2, states(:,i) + dt*K_1/2, F, M, I, m);
        K_3 = get_states_dot(time_V(i) + dt/2, states(:,i) + dt*K_2/2, F, M, I, m);
        K_4 = get_states_dot(time_V(i) + dt, states(:,i) + dt*K_3, F, M, I, m);
        
        % Update State Variables
        states(:,i+1) = states(:,i) + (dt/6) * (K_1 + 2*K_2 + 2*K_3 + K_4);
        wdot = K_1(3);
    end
    states = states(:,1:lengths);
    
    %% ====================== STATE VECTOR PROCESSING ======================
    u = states(1,:);
    v = states(2,:);
    w = states(3,:);
    p_deg = states(4,:)*180/pi;
    q_deg = states(5,:)*180/pi;
    r_deg = states(6,:)*180/pi;
    phi_deg = states(7,:)*180/pi;
    theta_deg = states(8,:)*180/pi;
    psi_deg = states(9,:)*180/pi;
    x = states(10,:);
    y = states(11,:);
    z = round(states(12,:),5);
    alpha_deg = atan(w./u)*180/pi;
    beta_deg = asin(v./sqrt(u.^2 + v.^2 + w.^2))*180/pi;
    
    states_vec_kutta = [
        u;
        v;
        w;
        beta_deg;
        alpha_deg;
        p_deg;
        q_deg;
        r_deg;
        phi_deg;
        theta_deg;
        psi_deg;
        x;
        y;
        z;
        ];
    
    %% ====================== SYSTEM MODEL DEFINITIONS ======================
   Approximations;
    %% ====================== SIMULATION EXECUTION ======================
    sim('Aircraft_Simulator_final_');
    
    %% ====================== RESULT PLOTTING ======================
    if long_or_lat == 1
        % Longitudinal Mode Plots
        ind_1 = [3, 7];
        states_data1{1} = states_vec_kutta(ind_1,:);
        states_data1{2} = fullLong(:,[2 3])';
        states_data1{3} = shortPeriod';
        state_labels_latex1 = state_labels_latex(ind_1);
        
        ind_2 = [1, 10];
        states_data2{1} = states_vec_kutta(ind_2,:);
        states_data2{2} = fullLong(:,[1,4])';
        states_data2{3} = longPeriod';
        state_labels_latex2 = state_labels_latex(ind_2);
        
        ind_3 = [1, 3, 7, 10];
        states_data3{1} = states_vec_kutta(ind_3,:);
        states_data3{2} = fullLong';
        state_labels_latex3 = state_labels_latex(ind_3);
        
        comparisons = table( ...
            {states_data1; states_data2; states_data3}, ...
            {state_labels_latex1; state_labels_latex2; state_labels_latex3}, ...
            {'Short Period Approx. Comparison'; 'Long Period Approx. Comparison'; 'Linear vs Nonlinear Models'}, ...
            { {'NonLinear Sim.', 'Linear Full Model', 'Short Period Approx.'}; ...
            {'NonLinear Sim.', 'Linear Full Model', 'Long Period Approx.'}; ...
            {'NonLinear Model', 'Linear Full Model'} }, ...
            'VariableNames', {'states_data', 'state_labels', 'plot_title', 'legend_labels'} ...
            );
        
        for i = 1:height(comparisons)
            plotStateComparisonsPro(time_V, comparisons.states_data{i}, ...
                comparisons.state_labels{i}, comparisons.plot_title{i}, ...
                comparisons.legend_labels{i}, dc);
        end
    else
        ind_4=[4,6,8,9,11];
        % Lateral Mode Plots
        states_data4{1} = states_vec_kutta(ind_4,:);
        states_data4{2} = fullLat';
        state_labels_latex4 = state_labels_latex(ind_4);
        ind_5=[4,6,8];
        states_data5{1} = states_vec_kutta(ind_4,:);
        states_data5{2} = fullLat(:,[1,2,3])';
        states_data5{3} = DR';
        state_labels_latex5 = state_labels_latex(ind_5);
        ind_6=[6,8,9];        
        states_data6{1} = states_vec_kutta(ind_6,:);
        states_data6{2} = fullLat(:,[2,3,4])';
        states_data6{3} = SP';
        state_labels_latex6 = state_labels_latex(ind_6);
        ind_7=[4,8];
        states_data7{1} = states_vec_kutta(ind_7,:);
        states_data7{2} = fullLat(:,[1,3])';
        states_data7{3} = DOF2';
        state_labels_latex7 = state_labels_latex(ind_7);
        ind_8=[6];
        states_data8{1} = states_vec_kutta(ind_8,:);
        states_data8{2} = fullLat(:,2)';
        states_data8{3} = DOF1';
        state_labels_latex8 = state_labels_latex(ind_8);
        
        comparisons = table( ...
            {states_data4; states_data5; states_data6; states_data7; states_data8}, ...
            {state_labels_latex4; state_labels_latex5; state_labels_latex6; state_labels_latex7; state_labels_latex8}, ...
            {'NonLinear vs Linear Models'; 'Dutch Roll Approximation Comparison'; 'Spiral Approximation Comparison'; '2DOF Approximation Comparison'; '1DOF Approximation Comparison'}, ...
            { {'NonLinear Model', 'Linear Full Model'}; ...
            {'NonLinear Sim.', 'Linear Full Model', 'DutchRoll Approx.'}; ...
            {'NonLinear Sim.', 'Linear Full Model', 'SpiralMode Approx.'}; ...
            {'NonLinear Sim.', 'Linear Full Model', '2DOF Approx.'}; ...
            {'NonLinear Sim.', 'Linear Full Model', '1DOF Approx.'} }, ...
            'VariableNames', {'states_data', 'state_labels', 'plot_title', 'legend_labels'} ...
            );
        
        for i = 1:height(comparisons)
            plotStateComparisonsPro(time_V, comparisons.states_data{i}, ...
                comparisons.state_labels{i}, comparisons.plot_title{i}, ...
                comparisons.legend_labels{i}, dc);
        end
    end
    
    
end
if long_or_lat==1
% Define system modifications and descriptions
modRedIndices = {[1,4],[2,3]};
outputIndices = {[2,3],[1,4]}; % Which states to keep
approxModels = {sys_SP, sys_LP}; % Corresponding models
modeNames = {'Short Period Approx.', 'Long Period Approx.'};
stateIndices = {ind_1, ind_2}; % Corresponding state indices

% Initialize tables
numTables = length(modRedIndices);
systemsTables = cell(numTables,1);

% Loop to create each systemsTable
for i = 1:numTables
    systemsTable = table();
    systemsTable.lineSpec = {'b-'; 'r--'};  % Line styles

    % Modify system and select outputs
    sys_mod = modred(sys_FL_long, modRedIndices{i}, 'truncate');
        
        systemsTable.sys = {sys_mod(outputIndices{i},:); approxModels{i}};
    
    % Descriptive names
    systemsTable.modeName = {'Linear Full Model'; modeNames{i}};

    % State and input names
    stateNames = state_labels_filename(stateIndices{i});
    inputNames = input_labels_latex([3,4]);

    % Store table and run comparison
    systemsTables{i} = systemsTable;
    export_system_comparison(systemsTable, stateNames, inputNames);
end


else
modRedIndices = {[4,5], [1,5], [2,4,5], [1,3,4,5]};
outputIndices = {[1,2,3], [2,3,4], [1,3], 2}; % Which states to keep
approxModels = {sys_DR, sys_Sp, sys_2D, sys_RO}; % Corresponding models
modeNames = {'DutchRoll Approx.', 'Spiral Approx.', '2DOF Approx.', '1DOF Approx.'};
stateIndices = {ind_5, ind_6, ind_7, ind_7}; % Corresponding state indices

% Initialize tables
numTables = length(modRedIndices);
systemsTables = cell(numTables,1);

% Loop to create each systemsTable
for i = 1:numTables
    systemsTable = table();
    systemsTable.lineSpec = {'b-'; 'r--'};  % Line styles

    % Modify system and select outputs
    sys_mod = modred(sys_FL_lat, modRedIndices{i}, 'truncate');
    if i==numTables
        systemsTable.sys = {sys_mod(outputIndices{i},1); approxModels{i}};
    else
        
        systemsTable.sys = {sys_mod(outputIndices{i},:); approxModels{i}};
    end
    
    % Descriptive names
    systemsTable.modeName = {'Linear Full Model'; modeNames{i}};

    % State and input names
    stateNames = state_labels_filename(stateIndices{i});
    inputNames = input_labels_latex([1,2]);

    % Store table and run comparison
    systemsTables{i} = systemsTable;
    export_system_comparison(systemsTable, stateNames, inputNames);
end
end


