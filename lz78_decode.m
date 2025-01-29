function decoded_string = lz78_decode(encoded_data)
    dict = {}; % Use a cell array for the dictionary
    decoded_string = '';
    dict_index = 1;

    for i = 1:size(encoded_data, 1)
        ref_index = encoded_data(i, 1);
        next_char = char(encoded_data(i, 2)); % Convert ASCII to char

        if ref_index == 0
            % New symbol
            decoded_string = [decoded_string, next_char];
            dict{dict_index} = next_char;
            dict_index = dict_index + 1;
        else
            % Reference to existing sequence
            sequence = dict{ref_index};
            sequence = [sequence, next_char];
            decoded_string = [decoded_string, sequence];
            dict{dict_index} = sequence;
            dict_index = dict_index + 1;
        end
    end
end