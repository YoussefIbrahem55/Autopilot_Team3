% Load the file
data = load('Benchmark_B747_FC5.mat');  % Replace with your actual file name

% Get all field names (benchmarks)
benchmarkNames = fieldnames(data);

% Define the sorting order
sortingOrder = {'u', 'v', 'w', 'beta_deg', 'alpha_deg', 'p', 'q', 'r', ...
                'phi_deg', 'theta_deg', 'psi_deg', 'x', 'y', 'z'};

% Create a structure to store the extracted matrices
benchmarks = struct();

% Loop through each benchmark
for i = 1:length(benchmarkNames)
    benchmarkStruct = data.(benchmarkNames{i}); % Access each benchmark struct
    
    % Initialize empty matrix
    numFields = length(sortingOrder);
    
    % Determine the number of data points (assuming all fields have same length)
    firstField = sortingOrder{1}; 
    if isfield(benchmarkStruct, firstField)
        numSamples = length(benchmarkStruct.(firstField));
    else
        numSamples = 0; % If first field doesn't exist, assume empty
    end
    
    benchmarkMatrix = NaN(numFields, numSamples); % Preallocate matrix
    
    % Fill the matrix row-wise based on the sorting order
    for j = 1:numFields
        if isfield(benchmarkStruct, sortingOrder{j})
            benchmarkMatrix(j, :) = benchmarkStruct.(sortingOrder{j}); % Store field values
        end
    end
    
    % Store the result in a struct with the same benchmark name
    benchmarks.(benchmarkNames{i}) = benchmarkMatrix;
end
save(benchmarks,'benchmarks.mat');