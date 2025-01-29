function [bwt_string, original_index] = BWT_encode(input_string)
    n = length(input_string);
    rotations = cell(n, 1);  % Use cell array to handle string rotations

    % Generate all cyclic rotations
    for i = 1:n
        rotations{i} = [input_string(i:end), input_string(1:i-1)];
    end

    % Sort the rotations lexicographically
    sorted_rotations = sort(rotations);

    % Extract the last column (BWT result) as a row vector
    bwt_string = char(cellfun(@(x) x(end), sorted_rotations))';  % Transpose to make it a row vector

    % Find the original string index
    original_index = find(strcmp(sorted_rotations, input_string));
end