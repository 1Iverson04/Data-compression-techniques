function decoded_str = arithmetic_decode(encoded_value, len, symbols, probabilities)
    % Uses the fractional number to reverse the process.
    %Identifies symbols based on probability ranges.
    %Reconstructs the original message.

    % Compute cumulative probabilities
    cum_prob = [0, cumsum(probabilities)];
    decoded_str = '';
    
    for i = 1:len
        % Find which symbol the encoded value belongs to
        idx = find(encoded_value >= cum_prob(1:end-1) & encoded_value < cum_prob(2:end));
        decoded_str = [decoded_str, symbols(idx)];
        
        % Update ranges
        range = cum_prob(idx+1) - cum_prob(idx);
        encoded_value = (encoded_value - cum_prob(idx)) / range;
    end
end
