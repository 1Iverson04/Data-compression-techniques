function encoded_data = lz78_encode(input_string)
    dict = containers.Map('KeyType', 'char', 'ValueType', 'int32');
    encoded_data = [];
    current_string = '';
    dict_index = 1;

    for i = 1:length(input_string)
        current_string = [current_string, input_string(i)];

        if ~isKey(dict, current_string)
            % Add the new sequence to the dictionary
            dict(current_string) = dict_index;
            dict_index = dict_index + 1;

            % Encode the sequence
            if length(current_string) == 1
                encoded_data = [encoded_data; 0, double(current_string(end))];
            else
                prefix = current_string(1:end-1);
                encoded_data = [encoded_data; dict(prefix), double(current_string(end))];
            end

            % Reset the current string
            current_string = '';
        end
    end

    % Handle the last sequence
    if ~isempty(current_string)
        if isKey(dict, current_string)
            encoded_data = [encoded_data; dict(current_string), NaN]; % Use NaN for empty next_char
        else
            encoded_data = [encoded_data; 0, double(current_string)];
        end
    end
end