function decoded_output = deflate_decode(deflate_output, window_size)
    % DEFLATE Decoder
    % Reverses Huffman decoding and LZ77 decoding to reconstruct the original data.

    % Step 1: Reconstruct Huffman Tree from Frequency Table
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

    % Step 2: Huffman Decoding (process numerical bitstream)
    function decoded_data = huffman_decode(compressed_data, huffman_tree)
        decoded_data = [];
        current_node = huffman_tree;
        
        for i = 1:length(compressed_data)
            bit = compressed_data(i); % Directly use numerical 0/1
            if bit == 0
                current_node = current_node.left;
            elseif bit == 1
                current_node = current_node.right;
            else
                error('Invalid compressed data: Expected binary bits (0 or 1).');
            end
            
            % Check if leaf node
            if isempty(current_node.left) && isempty(current_node.right)
                decoded_data = [decoded_data, current_node.symbol];
                current_node = huffman_tree;
            end
        end
    end

    % Step 3: LZ77 Decoding (process numerical array)
    function decoded_data = lz77_decode(encoded_data, window_size)
        decoded_data = [];
        i = 1;
        
        while i <= length(encoded_data)
            % Read tuples directly as numerical values
            if i+2 > length(encoded_data)
                error('Invalid encoded data: Incomplete tuple.');
            end
            offset = encoded_data(i);
            length_val = encoded_data(i+1);
            next_char = encoded_data(i+2);
            
            if offset == 0 && length_val == 0
                % Literal: (0, 0, char)
                decoded_data = [decoded_data, next_char];
            else
                % (offset, length, char) tuple
                start = length(decoded_data) - offset + 1;
                if start < 1 || start + length_val - 1 > length(decoded_data)
                    error('Invalid encoded data: Invalid offset or length.');
                end
                repeated_sequence = decoded_data(start:start + length_val - 1);
                decoded_data = [decoded_data, repeated_sequence, next_char];
            end
            i = i + 3;
        end
    end

    % Extract frequency table and compressed data
    frequency_table = deflate_output.frequency_table;
    compressed_data = deflate_output.compressed_data;

    % Rebuild Huffman tree and decode
    symbols = frequency_table(1, :);
    frequencies = frequency_table(2, :);
    huffman_tree = build_huffman_tree(symbols, frequencies);
    huffman_decoded_data = huffman_decode(compressed_data, huffman_tree);

    % LZ77 Decoding
    decoded_output = lz77_decode(huffman_decoded_data, window_size);
end