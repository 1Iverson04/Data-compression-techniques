function decoded = rle_decode(encoded_str)
    decoded = '';
    i = 1;
    
    while i <= length(encoded_str)
        char_val = encoded_str(i);
        i = i + 1;
        count_str = '';
        
        while (i <= length(encoded_str)) && isstrprop(encoded_str(i), 'digit')
            count_str = [count_str, encoded_str(i)];
            i = i + 1;
        end
        
        count = str2double(count_str);
        decoded = [decoded, repmat(char_val, 1, count)];
    end
end
