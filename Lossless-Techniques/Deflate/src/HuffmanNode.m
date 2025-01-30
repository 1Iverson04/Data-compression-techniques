classdef HuffmanNode
    properties
        symbol
        frequency
        left
        right
    end
    
    methods
        function obj = HuffmanNode(symbol, frequency)
            obj.symbol = symbol;
            obj.frequency = frequency;
            obj.left = [];
            obj.right = [];
        end
    end
end
