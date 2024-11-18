function encodedOutput = LZWencode(inputString)
    dictionary = containers.Map('KeyType', 'char', 'ValueType', 'int32');
    dictSize = 256;
    for i = 0:255
        dictionary(char(i)) = i;
    end

    currentString = '';
    encodedOutput = [];
    for i = 1:length(inputString)
        currentChar = inputString(i);
        combinedString = [currentString currentChar];
        if isKey(dictionary, combinedString)
            currentString = combinedString;
        else
            encodedOutput(end + 1) = dictionary(currentString);
            dictionary(combinedString) = dictSize;
            dictSize = dictSize + 1;
            currentString = currentChar;
        end
    end
    if ~isempty(currentString)
        encodedOutput(end + 1) = dictionary(currentString);
    end
end