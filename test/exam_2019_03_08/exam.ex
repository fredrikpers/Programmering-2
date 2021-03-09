defmodule Exam do


  #FRÅGA 1
  def decode([]) do [] end
  def decode([{_, 0} | tail]) do decode(tail) end
  def decode([{char, n} | tail]) do
    [char | decode([ {char, n - 1} | tail])]
  end

  #FRÅGA 2
  def zip([], []) do [] end
  def zip([h1 | t1], [h2 | t2]) do
    [{h1, h2} | zip(t1, t2)]
  end


  #FRÅGA 3

  def balance(:nil) do {0, 0} end

  def balance({:node, _val, left, right}) do
    {d_left, imb_left} = balance(left)
    {d_right, imb_right} = balance(right)
    depth = max(d_left, d_right) + 1
    imbalance = max( max(imb_left, imb_right), abs(d_left - d_right))
    {depth, imbalance}
  end



  #FRÅGA 4

  def eval({:add, a, b}) do
    eval(a) + eval(b)
  end

  def eval({:mul, a, b}) do
    eval(a) * eval(b)
  end

  def eval({:neg, _}) do
    -2
  end

  def eval(a) do
    a
  end

  #FRÅGA 5
  #Gray-Kodning

  def gray(0) do [ [] ] end

  def gray(n) do
    gray = gray(n - 1)
    gray_r = Enum.reverse(gray)
    update(gray, 0) ++ update(gray_r, 1)
  end

  def update([], _) do [] end

  def update([h | tail], n) do
    [ [n | h] | update(tail, n)]
  end


  #FRÅGA 7

  def fib() do
    fn() -> fib(1, 0) end
  end

  def fib(x, y) do
    {:ok, x, fn() -> fib(x + y, x) end}
  end


  def test() do
    cont = fib()
    {:ok, f1, _cont} = cont.()
    {:ok, f2, _cont} = cont.()
    {:ok, f3, _cont} = cont.()
    {:ok, f4, _cont} = cont.()
    {:ok, f5, _cont} = cont.()
    [f1, f2, f3, f4, f5]
  end

  def take(funk, 0) do {:ok, [], funk} end

  def take(funk, n) do
    {:ok, next, cont} = funk.()
    {:ok, rest, cont} = take(cont, n - 1)
    {:ok, [next | rest], cont}
  end


  #FRÅGA 8

  def facl(1) do [1] end
  def facl(n) do
    [fac(n) | facl(n - 1)]
  end

  def facl1(1) do [1] end
  def facl1(n) do
    rest = facl1(n - 1)
    [head | _] = rest
    [n * head | rest ]

  end
  def fac(1) do 1 end
  def fac(n) do
    n * fac(n - 1)
  end

  def fizzbuzz(n) do
    fizzbuzz(1, n + 1, 1, 1)
  end

  def fizzbuzz(x, x, _, _) do [] end
  def fizzbuzz(a, b, 3, 5) do [:fizzbuzz | fizzbuzz(a + 1, b, 1, 1)] end
  def fizzbuzz(a, b, 3, div5) do [:fizz | fizzbuzz(a + 1, b, 1, div5 + 1)] end
  def fizzbuzz(a, b, div3, 5) do [:buzz | fizzbuzz(a + 1, b, div3 + 1, 1)] end
  def fizzbuzz(a, b, div3, div5) do [a | fizzbuzz(a + 1, b, div3 + 1, div5 + 1)] end


end
