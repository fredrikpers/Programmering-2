defmodule Derivative do

    @type literal() ::  {:num, number()}  | {:var, atom()}
   
    @type expr() :: {:add, expr(), expr()}
                | {:mul, expr(), expr()}
                | literal()


    def test() do
        e = {:add,
                {:mul, {:num, 2}, {:var, :x}},
                {:num, 4}}
       d = deriv(e, :x)
       IO.write("expression: #{pprint(e)} \n")
       IO.write("derivative: #{pprint(d)} \n")
       IO.write("simplified: #{pprint(simplify(d))} \n")
       :ok
    end       
     
    # def deriv( {:num, 13}, :x) == {:num, 0}            
    # def deriv( {:var, :x}, :x) == {:num, 1}            
    # def deriv( {:var, :y}, :x) == {:num, 0}            

    def deriv({:num, _}, _), do: {:num, 0}

    def deriv({:var, v}, v), do: {:num, 1}
        
    def deriv({:var, _}, _), do: {:num, 0}

    def deriv({:mul, e1, e2}, v) do
        {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2,v)}}
    end

    def deriv({:add, e1, e2}, v) do
        {:add, deriv(e1,v), deriv(e2, v)}
    end

    def simplify({:add, e1, e2}) do
        simplify_add(simplify(e1), simplify(e2))
    end

    def simplify({:mul, e1, e2}) do
        simplify_mul(simplify(e1), simplify(e2))
    end

    def simplify(e) do e end

    def simplify_add({:num, 0}, e2) do e2 end
    def simplify_add(e1, {:num, 0}) do e1 end
    def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end

    def simplify_mul({:num, 0}) do {:num, 0} end
    def simplify_mul(_, {:num, 0}) do {:num, 0} end
    def simplify_mul({:num, 0}, e2) do e2 end
    def simplify_mul(e1, {:num, 1}) do e1 end
    def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end





    def pprint({:num, n}) do
        "#{n}"
    end
    
    def pprint({:var, v}) do
        "#{v}"
    end

    def pprint({:add, e1, e2}) do
        "(#{pprint(e1)} + #{pprint(e2)})"
    end

    def pprint({:mul, e1, e2}) do
        "#{pprint(e1)} * #{pprint(e2)}"
    end


end