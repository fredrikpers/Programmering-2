defmodule Sort do







    def qsort([]) do [] end
    def qsort([pivot | l]) do
        {small, large} = qsplit(pivot, l, [], [])
        small = qsort(small)
        large = qsort(large)
        append(small, [pivot | large])
    end

    def qsplit(_, [], small, large) do {small, large} end
    def qsplit(pivot, [head | tail], small, large) do
        if pivot >= head do
            qsplit(pivot, tail, [head | small], large)
        else
            qsplit(pivot, tail, small, [head | large])
        end
    end

    def append(small, large)  do
        case small do
            [] -> large
            [head | tail] -> [head | append(tail, large)]   
        end    
    end


end
