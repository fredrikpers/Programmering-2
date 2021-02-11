defmodule Crc do
    
    def crc(list) do crc(list ++ [0,0,0], [1,0,1,1])end

    def crc([h | t] = list, div) do
        cond do
            len(list) <= 3 -> list
            h == 0 -> crc(t, div)
            true -> crc(xor(list, div), div)
        end
    end

    def xor(list, []) do list end
    
    def xor([h1 | t1], [h2 | t2]) do
    cond do
      h1 == h2 ->
        [ 0 | xor(t1, t2) ]
      true ->
        [ 1 | xor(t1, t2)]
    end
  end

    #Length of list
    def len([]) do 0 end
    def len(list) do len(list, 0) end

    def len([], len) do len end
    def len([head | tail], len) do
        len(tail, len + 1 )
    end
    
end