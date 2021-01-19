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
    def add(x, l) do
        cond do
            l == [] -> [x]
            true -> IO.puts(1)
        end
        
    end 


end