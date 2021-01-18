defmodule Test do
  
  def double(n) do
    n*2
    end

   def fahrToCels(f) do
    (f-32)/1.8
    end 

    def rectArea(a,b) do
      a*b
      end

      def squareArea(a,b) do
      rectArea(a,b)
      end

      def circleArea(r) do
      r*r*:math.pi
      end

end