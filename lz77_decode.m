function decoded_string = lz77_decode(encoded_data)
    decoded_string = '';
    for i = 1:size(encoded_data, 1)
        offset = encoded_data(i, 1);  % Offset value
        length_match = encoded_data(i, 2);  % Length value
        next_char = char(encoded_data(i, 3));  % Convert ASCII to char

        if offset > 0
            % Ensure the offset is valid
            if offset > length(decoded_string) || offset < 1
                error('Invalid offset in encoded data.');
            end

            % Ensure the length is valid
            if length_match > offset
                error('Invalid length in encoded data.');
            end

            % Copy the sequence from the decoded string
            start_idx = length(decoded_string) - offset + 1;
            decoded_string = [decoded_string, decoded_string(start_idx:start_idx+length_match-1)];
        end

        % Append the next character
        decoded_string = [decoded_string, next_char];
    end
end