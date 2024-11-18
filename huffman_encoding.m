function [encodedOutput, encodingMap, decodingMap] = huffman_encoding(data)
    uniqueChars = unique(data);
    freq = zeros(length(uniqueChars), 1);
    
    for i = 1:length(uniqueChars)
        freq(i) = sum(data == uniqueChars(i));
    end
    
    nodes = cell(length(uniqueChars), 1);
    for i = 1:length(uniqueChars)
        nodes{i} = struct('char', uniqueChars(i), 'freq', freq(i), 'left', [], 'right', []);
    end
    
    while length(nodes) > 1
        nodes = sortNodesByFreq(nodes);
        
        left = nodes{1};
        right = nodes{2};
        mergedNode = struct('char', [], 'freq', left.freq + right.freq, 'left', left, 'right', right);
        nodes = [{mergedNode}; nodes(3:end)];
    end
    
    huffmanTree = nodes{1};
    
    encodingMap = containers.Map;
    decodingMap = containers.Map;
    createCodes(huffmanTree, '', encodingMap, decodingMap);
    
    encodedOutput = repmat(' ', 1, length(data) * max(cellfun(@length, values(encodingMap))));
    currentIndex = 1;
    for i = 1:length(data)
        code = encodingMap(data(i));
        encodedOutput(currentIndex:currentIndex + length(code) - 1) = code;
        currentIndex = currentIndex + length(code);
    end
    encodedOutput = encodedOutput(1:currentIndex - 1);
end

function sortedNodes = sortNodesByFreq(nodes)
    [~, order] = sort(cellfun(@(node) node.freq, nodes));
    sortedNodes = nodes(order);
end

function createCodes(node, currentCode, encodingMap, decodingMap)
    if ~isempty(node.char)
        encodingMap(node.char) = currentCode;
        decodingMap(currentCode) = node.char;
    else
        if ~isempty(node.left)
            createCodes(node.left, strcat(currentCode, '0'), encodingMap, decodingMap);
        end
        if ~isempty(node.right)
            createCodes(node.right, strcat(currentCode, '1'), encodingMap, decodingMap);
        end
    end
end