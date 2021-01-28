defmodule Lists do

    #Returns the first element in a list
    def tak(l) do
        cond do
            l == [] -> :no
            true -> [head | _] = l
            head
        end
    end

    #Drops the first element in a list
    def drp(l) do
        cond do
            l == [] -> :no
            true -> [_ | tail] = l
            tail
        end
    end

    #Returns the length of a list
    def len(l) do
        cond do
            l == [] -> 0
            true -> 1 + len(drp(l))
        end
    end

    #Length of the list version 2
    def len2([]) do 0 end
    def len2([_head | tail]) do 1 + len2(tail) end
    
    #Returns the sum of all elements in a list
    def sum(l) do
        cond do
            l == [] -> 0
            true -> tak(l) + sum(drp(l))
        end
    end

    #Duplicates all elements in a list
    def duplicate(l) do
        cond do
            l == [] -> []
            true -> [tak(l) | [tak(l) | duplicate(drp(l))]]
        end
    end
    
    #add the element x to the list if it is not in the list
    def add(x, []) do [x] end
    def add(x, [head | tail]) do
        cond do
            x == head -> [head | tail]
            true -> [head | add(x,tail)]
        end
    end

    #Removes all occurrences of x in list
    def remove(_x, []) do [] end
    def remove(x, [head | tail]) do
        cond do
            x == head -> remove(x, tail)
            true -> [head | remove(x, tail)]
        end
    end

    def unique([]) do [] end
    def unique([head | tail]) do
        [head | unique(remove(head, tail))]
    end

    def append([],[]) do [] end
    def append([],l) do l end
    def append(l,[]) do l end
    def append([head|tail], l) do
        [head|append(tail,l)]
        end

    #Reverse a list
    def nreverse([]) do [] end
    def nreverse([head | tail]) do
        r = nreverse(tail)
        append(r, [head])
    end

    def reverse(l) do
        reverse(l, [])
    end
    def reverse([], r) do r end
    def reverse([head | tail], r) do
        reverse(tail, [head | r])
    end

    def bench() do
        ls = [16, 32, 64, 128, 256, 512, 1024, 2048, 4096]
        n = 100
        # bench is a closure: a function with an environment
        bench = fn(l) ->
            seq = Enum.to_list(1..l)
            tn = time(n, fn -> nreverse(seq) end)
            tr = time(n, fn -> reverse(seq) end)
            :io.format("length: ~10w nrev; ~8w ms    rev: ~8w ms~n", [l, tn, tr])
    end

    # We use the library function Emun.each that will call
    # bench(l) for each element l in ls
    Enum.each(ls, bench)
    end

    # Time the execution time of the a function.
    def time(n, fun) do
        start = System.monotonic_time(:milliseconds)
        loop(n, fun)
        stop = System.monotonic_time(:milliseconds)
        stop - start
    end

    # Apply the function n times.
    def loop(n, fun) do
        if n == 0 do
            :ok
        else
            fun.()
            loop(n-1, fun)
        end
    end
end