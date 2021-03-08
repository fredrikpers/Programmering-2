defmodule Wait do

  def hello do
    receive do
      x -> IO.puts("aaa! surprise a message: #{x}")
    end
  end

  defmodule Tic do

    def first do
      receive do
        {:tic, x} ->
          IO.puts("tic: #{x}")
        second()
    end
  end

  def second do
    receive do
      {:tac, x} ->
        IO.puts("tac: #{x}")
        last()
        {:toe, x} ->
          IO.puts("toe: #{x}")
          last()
    end
  end

  def last do
    receive do
      {t, x} ->
        IO.puts("#{t}: #{x}")
    end
  end

end

end
