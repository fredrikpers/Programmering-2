defmodule Dinner do

  def start() do
    spawn(fn -> init() end)
  end

  def init() do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    sleep = 1234
    Philo.start(5, c1, c2, "Arendt", ctrl, sleep + 1)
    Philo.start(5, c2, c3, "Hypatia", ctrl, sleep + 2)
    Philo.start(5, c3, c4, "Simone", ctrl, sleep + 3)
    Philo.start(5, c4, c5, "Elisabeth", ctrl, sleep + 4)
    Philo.start(5, c5, c1, "Ayn", ctrl, sleep + 5)
    wait(5, [c1, c2, c3, c4, c5])
  end

  def wait(0, chopsticks) do
    Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
  end

  def wait(n, chopsticks) do
    receive do
      :done -> wait(n - 1, chopsticks)
      :abort -> Process.exit(self(), :kill)
    end
  end

end
