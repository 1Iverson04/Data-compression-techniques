function decoded_string = golomb_decode_string(encoded_data, m)
    % Decode the Golomb encoded data into a string
    decoded_data = [];
    i = 1;  % Pointer for traversing the encoded data
    
    while i <= length(encoded_data)
        % Find the position of the first 0 in the unary part (quotient)
        q = 0;
        while encoded_data(i) == 1
            q = q + 1;
            i = i + 1;
        end
        % Skip the 0 after the unary part
        i = i + 1;
        
        % Extract the remainder (binary part)
        remainder = bin2dec(num2str(encoded_data(i:i+log2(m)-1))) ;
        i = i + log2(m);  % Move the pointer past the binary part
        
        % Reconstruct the original data (ASCII values)
        decoded_data = [decoded_data, q * m + remainder];
    end
    
    % Convert the decoded ASCII values back to a string
    decoded_string = char(decoded_data);
end