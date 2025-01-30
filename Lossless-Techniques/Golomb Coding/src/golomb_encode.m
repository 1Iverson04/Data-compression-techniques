function encoded_data = golomb_encode(data, m)
    
    % Initialize encoded data as an empty array
    encoded_data = [];
    
    for i = 1:length(data)
        q = floor(data(i) / m);  % Quotient
        r = mod(data(i), m);     % Remainder
        
        % Encode the quotient in unary (using 1's followed by a 0)
        unary = repmat(1, 1, q);
        unary = [unary, 0];
        
        % Encode the remainder in binary (using ceil(log2(m)) bits)
        remainder = dec2bin(r, log2(m));
        
        % Append the unary and binary parts
        encoded_data = [encoded_data, unary, remainder - '0'];
    end
end
