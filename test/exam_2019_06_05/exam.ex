defmodule Exam do

  #Fråga 1
  #Ta bort det n-te talet i listan

  def drop([], _) do [] end
  def drop([head | tail], n) do
    cond do
      n == 1 -> tail
      true -> [head | drop(tail, n - 1)]
    end
  end

  #Fråga 2
  def rotate(list, n) do
    rotate(list, n, [])
  end

  def rotate(list, 0, acc) do
    append(list, Enum.reverse(acc))
  end

  def rotate([head | tail], n, acc) do
    rotate(tail, n - 1, [head | acc])
  end

  def append(list, list2) do
    list ++ list2
  end

  #Fråga 3

  def nth(1, {:leaf, val}) do {:found, val} end
  def nth(n, {:leaf, _}) do {:cond, n - 1} end

  def nth(n, {:node, left, right}) do
    case nth(n, left) do
      {:found, val} ->
        {:found, val}
      {:cond, k} ->
        nth(k, right)
    end
  end

  #Fråga 4
  #HP35

  def hp35(list) do hp35(list, []) end

  def hp35([], [head | _]) do head end

  def hp35([:add | tail], [a, b | stack]) do
    hp35(tail, [b + a | stack])
  end

  def hp35([:sub | tail], [a, b | stack]) do
    hp35(tail, [b - a | stack])
  end

  def hp35([head | tail], stack) do
    hp35(tail, [head | stack])
  end



  #Fråga 5
  #Pascals triangel

  def pascal(1) do [1] end

  def pascal(n) do
    [1 | next(pascal(n - 1))]
  end

  def next([1]) do [1] end
  def next([head | tail]) do
    [a | _] = tail
    [head + a | next(tail)]
  end


  #FRÅGA 6

  def trans(:nil, _) do :nil end #EMPTY TREE
  def trans({:leaf, value}, funk) do {:leaf, funk.(value)} end
  def trans({:node, left, right},funk) do
    {:node, trans(left, funk), trans(right, funk)}
  end

  def remit(tree, n) do
    {:node, trans(tree, fn x -> rem(x, n) end )}
  end

  #FRÅGA 8

  @docp """


  def shortest(from, to, map) do
    ... = Map.new([{to, 0}])
    ... = check(from, to, ... , ...)
    dist
  end

  def check(from, to, ..., ....) do
    case ... do
      nil -> shortest(from, to, ..., ...)
      distance -> ...
    end
  end

  def shortest(from, to, ..., ...) do
    ... = Map.put(..., ..., :inf)
    ... = Map.get(..., from)
    ... = select(neightbours, to, update, map)
    ...
    {:found, dist, updated}
  end

  def select([], _, ..., ...) do ... end
  def select([{:city, next, d1} | rest], to, ..., ... ) do
    ... check(next, to, ..., ...)
    dist = add(d1, d2)
    ... = select(rest, to, ..., ...)

    if sele < dist do
      {:found, sele, updated}
    else
      {:found, dist, updated}
    end
  end

  def add(..., ...) do ... end
  def add(..., ...) do ... end
  def add(..., ...) do ... end
"""

  #FRÅGA 9
  #HP35 med processer

  def init() do
    spawn(fn -> hp36([]) end)
  end

  def hp36(stack) do
    receive do
      {:int, int} -> hp36([int | stack])
      {:add, add} ->
      [x, y | rest] = stack
      send(add, {:res, x + y})
    end
  end

  def test do
    hp = init()
    send(hp, {:int, 3})
    send(hp, {:int, 4})
    send(hp, {:add, self()})
    receive do
      {:res, res} ->
        res
    end
  end


end
