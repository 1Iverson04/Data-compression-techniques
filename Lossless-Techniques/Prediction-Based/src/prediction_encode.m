function [encoded_string, encoded_integers] = prediction_encode(input_string, input_integers)
    % --- String Encoding ---
    encoded_string = zeros(1, length(input_string), 'double');  % Use double to preserve negatives
    encoded_string(1) = double(input_string(1));  % Store ASCII code of first character
    for i = 2:length(input_string)
        encoded_string(i) = double(input_string(i)) - double(input_string(i-1));  % Compute difference
    end
    
    % --- Integer Encoding ---
    encoded_integers = zeros(1, length(input_integers), 'double');
    encoded_integers(1) = input_integers(1);  % First integer remains unchanged
    for i = 2:length(input_integers)
        encoded_integers(i) = input_integers(i) - input_integers(i-1);  % Compute difference
    end
end
