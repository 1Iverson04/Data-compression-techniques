function codebook = shannon_fano_encode(input_string)
    % Calculate symbol frequencies
    symbols = unique(input_string);
    freq = zeros(1, length(symbols));
    for i = 1:length(symbols)
        freq(i) = sum(input_string == symbols(i));
    end

    % Sort symbols in descending order of frequency
    [freq, idx] = sort(freq, 'descend');
    symbols = symbols(idx);

    % Recursively build the codebook
    codebook = containers.Map('KeyType', 'char', 'ValueType', 'any');
    build_codebook(symbols, freq, '', codebook);

    % Nested function to build the codebook
    function build_codebook(symbols, freq, code, codebook)
        if length(symbols) == 1
            codebook(symbols(1)) = code;
            return;
        end

        % Split the symbols into two groups with approximately equal probabilities
        total_freq = sum(freq);
        half_freq = total_freq / 2;
        cumulative_freq = 0;
        split_idx = 1;

        while cumulative_freq + freq(split_idx) <= half_freq
            cumulative_freq = cumulative_freq + freq(split_idx);
            split_idx = split_idx + 1;
        end

        % Assign 0 to the left group and 1 to the right group
        build_codebook(symbols(1:split_idx-1), freq(1:split_idx-1), [code '0'], codebook);
        build_codebook(symbols(split_idx:end), freq(split_idx:end), [code '1'], codebook);
    end
end