defmodule High do

    def map([], _) do [] end    
    def map([h | t], op) do [op.(h) | map(t, op)] end   

    def filter([], _) do [] end
    def filter([h | t], op) do 
        if op.(h) do
            [h | filter(t, op)]
        else
            filter(t, op)
         end
    end

    def infinity() do
        fn () -> infinity(0) end
    end

    def infinity(n) do
        [n | fn() -> infinity(n+1) end]
    end

    def reduce({:range, from, to}, acc, fun) do
        if from <= to do
            reduce({:range, from + 1, to}, fun.(from,acc), fun)
        else 
            acc
        end
    end

    def sum(range) do
        reduce(range, 0, fn(x,acc) -> x + acc end)
    end


end