function decoded_string = BWT_decode(bwt_string, original_index)
    n = length(bwt_string);
    table = cell(n, 1);

    % Initialize the table with single characters
    for i = 1:n
        table{i} = bwt_string(i);
    end

    % Reconstruct the original matrix
    for i = 1:n-1
        % Sort the table lexicographically
        table = sort(table);
        % Prepend the BWT string to each row
        for j = 1:n
            table{j} = [bwt_string(j), table{j}];
        end
    end

    % Extract the original string
    decoded_string = table{original_index};
end