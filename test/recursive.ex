defmodule Recursive do
    
    def product(m, n) do
        if m == 0 do
            0
        else
            n + product(m-1, n)
        end 
        
    end

    def product_case(m,n) do
        case m do
            0 ->
                0
            _ -> 
                n + product_case(m-1, n)
        end
    end

    def product_cond(m, n) do
        cond do
            m == 0 -> 
                0
            true ->
                n + product_cond(m-1, n)
        end
    end

    def product_clauses(0, _) do 0 end
    def product_clauses(m, n) do
        product_clauses(m-1, n) + n
    end

    def exp(x, n) do
        case n do
            0 ->
                1
            _ ->
                product(x, exp(x, n-1))
        end
    end

    def exp_built_in(x, n) do
        cond do
            n == 1 ->
                x
            rem(n,2) == 0 -> 
                exp_built_in(x, div(n,2)) * exp_built_in(x, div(n,2))
            rem(n,2) == 1 ->
                exp_built_in(x, n-1) * x        
        end
    end    
end