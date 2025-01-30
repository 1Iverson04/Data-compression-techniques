function deflate_output = deflate_encode(input_string, window_size)
    % DEFLATE Compression Algorithm
    % Combines LZ77 and Huffman coding for compression.

    % Step 1: LZ77 Encoding
    function encoded_data = lz77_encode(input_string, window_size)
        n = length(input_string);
        encoded_data = zeros(n, 3); % Preallocate for maximum possible tuples
        encoded_count = 0; % Counter for the number of tuples added
        i = 1;

        while i <= n
            % Define the search window
            window_start = max(1, i - window_size);
            search_buffer = input_string(window_start:i-1);

            % Initialize match variables
            max_length = 0;
            max_offset = 0;

            % Limit the search to the last `window_size` characters
            for j = length(search_buffer):-1:1
                match_length = 0;
                while (i + match_length <= n) && ...
                      (j + match_length <= length(search_buffer)) && ...
                      (input_string(i + match_length) == search_buffer(j + match_length))
                    match_length = match_length + 1;
                end

                % Update if a longer match is found
                if match_length > max_length
                    max_length = match_length;
                    max_offset = i - window_start - j + 1;

                    % Early exit if the maximum possible match is found
                    if max_length == window_size
                        break;
                    end
                end
            end

            % Add the encoded tuple (offset, length, next_char)
            if max_length > 0
                if i + max_length > n
                    next_char = ''; % No more characters left
                else
                    next_char = input_string(i + max_length);
                end
                encoded_count = encoded_count + 1;
                encoded_data(encoded_count, :) = [max_offset, max_length, double(next_char)];
                i = i + max_length + 1;
            else
                % No match found, encode as (0, 0, current_char)
                encoded_count = encoded_count + 1;
                encoded_data(encoded_count, :) = [0, 0, double(input_string(i))];
                i = i + 1;
            end
        end

        % Trim the preallocated array to the actual number of tuples
        encoded_data = encoded_data(1:encoded_count, :);
    end

    % Step 2: Build Huffman Tree
    function huffman_tree = build_huffman_tree(symbols, frequencies)
        % Create a priority queue (min-heap) of Huffman nodes
        heap = [];
        for i = 1:length(symbols)
            heap = [heap, HuffmanNode(symbols(i), frequencies(i))];
        end

        % Build the Huffman tree
        while length(heap) > 1
            % Sort the heap based on frequency
            [~, order] = sort(arrayfun(@(x) x.frequency, heap));
            heap = heap(order);

            % Extract the two nodes with the smallest frequencies
            left = heap(1);
            right = heap(2);
            heap = heap(3:end);

            % Create a new node with the sum of frequencies
            new_node = HuffmanNode([], left.frequency + right.frequency);
            new_node.left = left;
            new_node.right = right;

            % Add the new node to the heap
            heap = [heap, new_node];
        end

        % The remaining node is the root of the Huffman tree
        huffman_tree = heap(1);
    end

    % Step 3: Generate Huffman Codes
    function codes = generate_huffman_codes(node, prefix, codes)
        if isempty(node.left) && isempty(node.right)
            % Leaf node: store the code
            codes(node.symbol) = prefix;
        else
            % Traverse left and right subtrees
            if ~isempty(node.left)
                codes = generate_huffman_codes(node.left, [prefix, 0], codes);
            end
            if ~isempty(node.right)
                codes = generate_huffman_codes(node.right, [prefix, 1], codes);
            end
        end
    end

    % Step 4: Huffman Encoding
    function compressed_data = huffman_encode(data, codes)
        compressed_data = [];
        for i = 1:length(data)
            compressed_data = [compressed_data, codes(data(i))];
        end
    end

    % Step 5: Deflate Algorithm
    lz77_data = lz77_encode(input_string, window_size);

    % Flatten LZ77 data into a single stream
    data_stream = [];
    for i = 1:size(lz77_data, 1)
        data_stream = [data_stream, lz77_data(i, :)];
    end

    % Build Huffman tree and generate codes
    symbols = unique(data_stream);
    frequencies = histcounts(data_stream, [symbols, max(symbols)+1]);
    huffman_tree = build_huffman_tree(symbols, frequencies);
    codes = generate_huffman_codes(huffman_tree, [], containers.Map('KeyType', 'double', 'ValueType', 'any'));

    % Huffman Encoding
    compressed_data = huffman_encode(data_stream, codes);

    % Create the frequency table
    frequency_table = [symbols; frequencies];

    % Return the compressed data as a numerical array
    deflate_output.frequency_table = frequency_table;
    deflate_output.compressed_data = compressed_data;
end
