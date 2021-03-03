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

      def sum([]) do 0 end
      def sum([h | t]) do h + sum(t) end

      def reverse ([]) do [] end
      def reverse([h | t]) do
        reverse(t) ++ [h]
      end

      def fib(0) do 0 end
      def fib(1) do 1 end
      def fib(n) do fib(n-1) + fib(n-2) end

      def fib1(0) do {0, nil} end
      def fib1(1) do {1, 0} end
      def fib1(n) do
        {n1, n2} = fib1(n-1)
        {n1 + n2, n1}
      end

      defmodule Color do
        def green(text) do
          IO.ANSI.green() <> text
        end
      end
      IO.puts Color.green("This text is green")

end
