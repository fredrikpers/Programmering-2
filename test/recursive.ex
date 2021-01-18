defmodule Recursive do
    def product(m, n) do
        if m == 0 do
            0
        else
        n + (m-1)*n 
        end
    end

    def product_case(m,n) do
        case m do
            0 ->
                0
            _ -> 
                n + (m-1)*n 

        end
    end

    def product_cond(m, n) do
        cond do
            m == 0 -> 
                0
            true ->
                n + (m-1)*n 
        end
    end

end