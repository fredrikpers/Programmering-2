defmodule Exam_2020 do

  def toggle([]) do [] end
  def toggle([x]) do [x] end
  def toggle([a,b | tail]) do
    [b, a | toggle(tail)]
  end

  def push([], elem) do [elem] end
  def push([head | tail], elem) do
    [elem, head | tail]
  end

  def pop([]) do :no end
  def pop([head | tail]) do
    {:ok, head , tail}
  end


  def flatten([head | tail]) do
    flatten(head) ++ flatten(tail)
  end

  def flatten([]) do [] end
  def flatten(x) do [x] end

  def index(list) do
    index(list, 0)
  end

  def index([head | tail], n) do
    cond do
      head > n -> index(tail, n + 1)
      true -> n
    end
  end

  def compact(:nil) do :nil end
  def compact({:leaf, x}) do {:leaf, x} end
  def compact({:node, {:leaf, x}, {:leaf, x}}) do {:leaf, x} end
  def compact({:node, :nil, {:leaf, x}}) do {:leaf, x} end
  def compact({:node, {:leaf, x}, :nil}) do {:leaf, x} end

  def compact({:node, left, right}) do
    {:node, compact(left), compact(right)}
  end

  #Om tom lista
  def flatten1([]) do [] end

  #Om tom lista i huvud
  def flatten1([ [] | rest]) do
    flatten1(rest)
  end

  #Om huvud är en lista
  def flatten1([[head | tail] | rest]) do
    flatten1([head, tail | rest])
  end
  #Om ensam variabel i huvud
  def flatten1([head | tail]) do
    [head | flatten1(tail)]
  end

  def append(a) do
    app = fn x, f ->
      case x do
        1 -> 1
        2 -> 1
        _  -> f.(x - 1, f) + f.(x - 2, f)
      end
    end
    app.(a, app)
  end


end
