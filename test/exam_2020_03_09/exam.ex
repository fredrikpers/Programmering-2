defmodule Exam do

  #FRÅGA 1
  #[] -> []
  #[:a] -> [:a]
  #[:a, :b] -> [:b, :a]
  #[:a, :b, :c] -> [:b, :a, :c]

  def toggle([a, b | rest]) do
    [b, a | toggle(rest)]
  end
  def toggle([x]) do [x] end
  def toggle([]) do [] end

  #FRÅGA 2

  #Push lägg till föremål på stacken och returnera stacken
  #Pop ta bort föremål på stacekn och returnera stacken

  def push(stack, elem) do
    stack ++ [elem]
  end

  def pop([]) do :no end

  def pop([elem | rest]) do
    stack = rest
    {:ok, elem, rest}
  end

  #FRÅGA 3

  #Flatten, tar emot en lista av listor och returnerar en enkel lista

  # [1,[2],[[3,[4,5]], 6]] -> [1,2,3,4,5,6]

  def flatten([]) do [] end
  def flatten([head | tail]) do
    flatten(head) ++ flatten(tail)
  end

  def flatten(x) do
    [x]
  end

  #FRÅGA 4

  #h-värde
  #Skicka in en lista av löprundor, räkna upp så länge countern är mindre än löprundan

  def index(list) do
    index(list, 0)
  end

  def index([], counter) do counter end
  def index([x], counter) do counter + 1 end
  def index([head | tail], counter) do
    cond do
      head > counter -> index(tail, counter + 1)
      true -> counter
    end
  end

  #FRÅGA 5
  # {:node, {:leaf, 4}, {:leaf, 4}} -> {:leaf, 4}
  # {:node, {:leaf, 5}, {:node, :nil, {:leaf, 4}}} -> {:node, {:leaf, 5}, {:leaf, 4}}

  def compact(:nil) do :nil end
  def compact({:leaf, val}) do {:leaf, val} end
  def compact({:node, left, right}) do
    cl = compact(left)
    cr = compact(right)
    combine(cl, cr)
  end

  def combine(:nil, {:leaf, val}) do {:leaf, val} end
  def combine({:leaf, val}, :nil) do {:leaf, val} end
  def combine({:leaf, val}, {:leaf, val}) do
    {:leaf, val}
  end
  def combine(left, right) do
    {:node, left, right}
  end



  #FRÅGA 7


  def primes() do
    fn() -> {:ok, 2, fn() -> sieve(2, fn() -> next(3) end) end} end
  end

  def next(n) do
    {:ok, n, fn() -> next(n+1) end}
  end

  def sieve(p, f) do
    {:ok, n, f} = f.()
    if rem(n, p) == 0 do
      sieve(p, f)
    else
      {:ok, n, fn() -> sieve(n, fn() -> sieve(p, f) end) end}
    end
  end

  #FRÅGA 8

  #En bättre flatten

  def flatten_better([]) do [] end

  def flatten_better([[head] | tail]) do
    [head | flatten(tail)]
  end

  def flatten_better([head | tail]) do
    [head | flatten_better(tail)]
  end


  #FRÅGA 9

  # [1,2,3,4] -> [3,4,5,6] genom processer

  def pmap(list, funk) do
    refs = Enum.map(list, paralell(funk))
    Enum.map(refs, collect())
  end

  def paralell(funk) do
      me = self()
      fn (x) -> ref = make_ref()
      spawn(fn() ->
        res = funk.(x)
        send(me, {:ok, ref, res})
      end)
      ref
      end
  end

  def collect() do
    fn(r) -> receive do
    {:ok, ^r, res} -> res
    end
  end
end

end
