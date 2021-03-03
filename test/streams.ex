defmodule Streams do
    
    # {:range, from, to}

#    def sum({:range, to, to}) do to end
#    def sum({:range, from, to}) do from + sum({:range, from + 1, to}) end

#   def reduce({:range, from, to}, acc, fun) do
#       if from <= to do
#            reduce({:range, from + 1, to}, fun.(from, acc), fun)
#        else
#            acc    
#        end
#    end

#   def sum(range) do reduce(range, 0, fn(x,a) -> x + a end) end

    def take({:range, _, _}, 0) do [] end
    def take({:range, from, to}, n) do 
        [ from | take({:range, from + 1, to}, n - 1 )]
    end

    def reduce({:range, from, to}, {:cont, acc}, fun) do
        if from <= to do
            reduce({:range, from+1, to}, fun.(from, acc), fun)
        else
            {:done, acc}
        end
    end
    def reduce({:range, from, to}, {:halt, acc}, fun) do
        {:halted, acc}
    end

    def sum(range) do
        reduce(range, {:cont, 0}, fn(x,a) -> {:cont, x + a} end)
    end


    def take(range, n) do
        reduce(range, {:cont, {:sofar, 0 , []}},
            fn(x, {:sofar, s, acc}) ->
                if s == n do
                    {:halt, acc}
                else
                    {:cont, {:sofar, s+1, [x | acc]}}
                end    
            end)
    end

   def takeTo(range, n) do
        reduce(range, {:cont, []},
            fn(x , a) ->
            if x < n do
                {:cont, [x | a] }
            else
                {:halt, a}    
            end
        end)    
    end

    def takeToSum(range, n) do
        reduce(range, {:cont, 0},
            fn(x , a) ->
            if x < n do
                {:cont, x + a }
            else
                {:halt, a}    
            end
        end)    
    end

     def takeToExceed(range, n) do
        reduce(range, {:cont, 0},
            fn(x , a) ->
            if x + a < n do
                {:cont, x + a }
            else
                {:halt, x}    
            end
        end)    
    end

end