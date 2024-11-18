function decodedOutput = LZWdecode(encodedInput)
    dictionary = containers.Map('KeyType', 'int32', 'ValueType', 'char');
    for i = 0:255
        dictionary(i) = char(i);
    end

    currentString = dictionary(encodedInput(1));
    decodedOutput = currentString;
    dictSize = 256;

    for i = 2:length(encodedInput)
        code = encodedInput(i);
        
        if isKey(dictionary, code)
            entry = dictionary(code);
        elseif code == dictSize
            entry = [currentString currentString(1)];
        else
            error('Invalid LZW code encountered: %d', code);
        end

        decodedOutput = [decodedOutput entry];
        dictionary(dictSize) = [currentString entry(1)];
        dictSize = dictSize + 1;
        currentString = entry;
    end
end