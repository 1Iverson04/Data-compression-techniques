function [decoded_string, decoded_integers] = prediction_decode(encoded_string, encoded_integers)
    % --- String Decoding ---
    decoded_ascii = zeros(1, length(encoded_string), 'double');
    decoded_ascii(1) = encoded_string(1);  % First ASCII code
    for i = 2:length(encoded_string)
        decoded_ascii(i) = encoded_string(i) + decoded_ascii(i-1);  % Rebuild ASCII codes
    end
    decoded_string = char(decoded_ascii);  % Convert ASCII codes to characters
    
    % --- Integer Decoding ---
    decoded_integers = zeros(1, length(encoded_integers), 'double');
    decoded_integers(1) = encoded_integers(1);  % First integer
    for i = 2:length(encoded_integers)
        decoded_integers(i) = encoded_integers(i) + decoded_integers(i-1);  % Rebuild integers
    end
end