defmodule Wait do

  def hello do
    receive do
      x -> IO.puts("aaa, surprise, a message: #{x}")
    end
  end

  # p = spawn(Wait, :hello, [])
  # send p, "hello"

  # p = spawn(Wait, :hello, [])
  # Process.register(p, :foo)
  # send :foo, "hello"

  defmodule Tic do

    def first do
      receive do
        {:tic, x} -> IO.puts("tic: #{x}")
        second()
      end
    end

    defp second do
      receive do
        {:tac, x} -> IO.puts("tac: #{x}")
        last()
        {:toe, x} -> IO.puts("toe: #{x}")
        last()
      end
    end

    defp last do
      receive do
        {t, x} -> IO.puts("#{t}: #{x}")
      end
    end

  end



end
