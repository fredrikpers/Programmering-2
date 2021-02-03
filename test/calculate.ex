defmodule Calculate do

    def eval({:int, n}) do n end

    def eval({:add, a, b}) do
        eval(a) + eval(b)
    end

    def eval{:sub, a, b} do
        eval(a) - eval(b)
    end

    def eval({:mult, a, b}) do
        eval(a) * eval(b) 
    end

    def lookup(var, [{:bind, var, value} | _]) do
        {:int, value}
    end

    def lookup(var, [_ | rest]) do
        lookup(var,rest)
    end
    
    def eval({:var, name}, bindings) do
        eval(lookup(name, bindings))        
    end




    ## pack([:a, :b, :a, :c, :b, :a]) => [[:a, :a], [:c], [:b, :b]]

    ## pack([]) ?? []

    def pack([]) do [] end
    def pack([h | t]) do
        insert(h, pack(t))
    end

    def insert(h, []) do [[h]] end

    def insert(h, [ [h|t] | rest ]) do
        [ [h, h | t ] | rest ]
    end

    def insert(h, [first | rest]) do
        [ first | insert(h , rest )]
    end
end