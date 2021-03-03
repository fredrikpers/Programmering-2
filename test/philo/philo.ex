defmodule Philo do

  def start(hunger, right, left, name, ctrl, sleep) do
    spawn_link(fn -> dreaming(hunger, right, left, name, ctrl, sleep) end)
  end

  def dreaming(0, right, left, name, ctrl, sleep) do
    IO.puts(" #{name} is done eating")
    sleep(sleep)
    send(ctrl, :done)
  end

  def dreaming(hunger, right, left, name, ctrl, sleep) do
    IO.puts("#{name} is dreaming with #{hunger}")
    sleep(sleep)
    waiting(hunger, right, left, name, ctrl, sleep)
  end

  def waiting(hunger, right, left, name, ctrl, sleep) do
    IO.puts("#{name} is waiting!")
    case Chopstick.request(right) do
        :ok -> IO.puts("#{name} receives right chopstick")
        sleep(sleep)
      end

    case Chopstick.request(left) do
          :ok -> IO.puts("#{name} got both chopsticks! :)")
          eating(hunger, right, left, name, ctrl, sleep)
          sleep(sleep)
        end
  end

  def eating(hunger, right, left, name, ctrl, sleep) do
    IO.puts(" #{name} is eating")

    sleep(sleep)

    IO.puts(" #{name} is returning sticks")
    Chopstick.return(left)
    Chopstick.return(right)

    dreaming(hunger - 1, right, left, name , ctrl, sleep)

  end

  def sleep(0) do :ok end
  def sleep(t) do :timer.sleep(:rand.uniform(t)) end

end
