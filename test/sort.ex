defmodule Sort do
    
    def insert(element, []) do [element] end
    def insert(element, [head | tail]) do
        cond do
            element > head -> [head | insert(element, tail)]
            true -> [element, head | tail]
        end
    end
    
end