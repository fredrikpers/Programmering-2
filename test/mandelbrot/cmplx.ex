defmodule Cmplx do

    def new(r, i) do {:cmplx, r, i}  end
   
    def add({:cmplx, a1, b1}, {:cmplx, a2, b2}) do
        {:cmplx, a1+a2, b1+b2}  
    end
   
    def sqr({:cmplx, a, b}) do
        {:cmplx, a*a - b*b , b*a*2}
    end
    
    def abs({:cmplx, a, b}) do 
        :math.sqrt(a*a + b*b)
    end

end