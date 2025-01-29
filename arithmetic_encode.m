function [low, high] = arithmetic_encode(input_str, symbols, probabilities)
    %Computes probability ranges for each symbol.
    %Updates a low and high range iteratively.
    %Encodes the message into a single fractional number.

    % Compute cumulative probabilities
    cum_prob = [0, cumsum(probabilities)];
    
    low = 0;
    high = 1;
    
    for i = 1:length(input_str)
        symbol = input_str(i);
        idx = find(symbols == symbol); % Find index of symbol
        
        range = high - low;
        high = low + range * cum_prob(idx + 1);
        low = low + range * cum_prob(idx);
    end
end
