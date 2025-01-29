function encoded_data = lz77_encode(input_string, window_size)
    n = length(input_string);
    encoded_data = zeros(n, 3); % Preallocate for maximum possible tuples
    encoded_count = 0; % Counter for the number of tuples added
    i = 1;

    while i <= n
        % Define the search window
        window_start = max(1, i - window_size);
        search_buffer = input_string(window_start:i-1);

        % Initialize match variables
        max_length = 0;
        max_offset = 0;

        % Limit the search to the last `window_size` characters
        for j = length(search_buffer):-1:1
            match_length = 0;
            while (i + match_length <= n) && ...
                  (j + match_length <= length(search_buffer)) && ...
                  (input_string(i + match_length) == search_buffer(j + match_length))
                match_length = match_length + 1;
            end

            % Update if a longer match is found
            if match_length > max_length
                max_length = match_length;
                max_offset = i - window_start - j + 1;

                % Early exit if the maximum possible match is found
                if max_length == window_size
                    break;
                end
            end
        end

        % Add the encoded tuple (offset, length, next_char)
        if max_length > 0
            if i + max_length > n
                next_char = ''; % No more characters left
            else
                next_char = input_string(i + max_length);
            end
            encoded_count = encoded_count + 1;
            encoded_data(encoded_count, :) = [max_offset, max_length, double(next_char)];
            i = i + max_length + 1;
        else
            % No match found, encode as (0, 0, current_char)
            encoded_count = encoded_count + 1;
            encoded_data(encoded_count, :) = [0, 0, double(input_string(i))];
            i = i + 1;
        end
    end

    % Trim the preallocated array to the actual number of tuples
    encoded_data = encoded_data(1:encoded_count, :);
end