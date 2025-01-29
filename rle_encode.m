function encoded = rle_encode(input_str)
    n = length(input_str);
    encoded = '';
    
    i = 1;
    while i <= n
        count = 1;
        while (i < n) && (input_str(i) == input_str(i + 1))
            count = count + 1;
            i = i + 1;
        end
        encoded = [encoded, input_str(i), num2str(count)];
        i = i + 1;
    end
end
