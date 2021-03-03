defmodule Chopstick do

  def start do
    stick = spawn_link(fn -> available() end)
    {:stick, stick}
  end

  def available() do
    receive do
      {:request, from} ->
        send(from, :granted)
        gone()
      :quit -> :ok
    end
  end

  def gone() do
    receive do
      :return -> available()
      :quit -> :ok
    end
  end

  def request({:stick, stick}) do
    send(stick, {:request, self()})
    receive do
      :granted -> :ok
    end
  end

  def return({:stick, stick}) do
    send(stick, :return)
  end

  def quit({:stick, stick}) do
    send(stick, :quit)
  end

end
