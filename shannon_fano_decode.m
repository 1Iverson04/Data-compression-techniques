function decoded_string = shannon_fano_decode(encoded_string, codebook)
    % Reverse the codebook (binary code -> symbol)
    reverse_codebook = containers.Map('KeyType', 'char', 'ValueType', 'char');
    symbols = keys(codebook);
    for i = 1:length(symbols)
        reverse_codebook(codebook(symbols{i})) = symbols{i};
    end

    % Decode the binary string
    decoded_string = '';
    current_code = '';
    for i = 1:length(encoded_string)
        current_code = [current_code encoded_string(i)];
        if isKey(reverse_codebook, current_code)
            decoded_string = [decoded_string reverse_codebook(current_code)];
            current_code = '';
        end
    end
end