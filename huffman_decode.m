function decodedOutput = huffman_decode(encodedOutput, decodingMap)
    currentCode = '';
    decodedOutput = '';

    for i = 1:length(encodedOutput)
        currentCode = [currentCode, encodedOutput(i)];
        
        if isKey(decodingMap, currentCode)
            decodedOutput = [decodedOutput, decodingMap(currentCode)];
            currentCode = '';
        end
    end
end