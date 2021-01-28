defmodule Binary do
    def append([], []) do [] end
    def append([], list) do list end
    def append(list, []) do list end
    def append([head | tail], list) do
        [head | append(tail, list)]
    end 

    def to_binary(0) do [] end

    def to_binary(n) do
        cond do
            rem(n,2) == 1 -> append( to_binary(div(n,2)) , [1])
            rem(n,2) == 0 -> append( to_binary(div(n,2)) , [0])
        end  
    end

    def to_better(n) do to_better(n, []) end

    def to_better(0, b) do b end

    def to_better(n, b) do
        to_better(div(n, 2), [rem(n, 2) | b])
    end


    # [] -> 0
    # [0,1,0,1] -> 5
    # [0,1,0,1] = 2^3 *0 + 2^2 *1 + 2^1 *0 + 2*0 *1 = 5
    # [1,1,1,1] = 2^3 *1 + 2^2 *1 + 2^1 *1 + 2*0 *1 = 15

    def to_integer(x) do to_integer(x, 0) end
    def to_integer([], n) do n end

    def to_integer([head | tail] = list, n) do
        to_integer(tail, round(n + :math.pow( 2, length(list) -1 ) * head) )
    end

end