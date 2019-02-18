defmodule Chopstick do
    def start do
        stick = spawn_link(fn -> available() end)
    end

    def available() do
        receive do
            {:request, from} -> 
                send(from, :confirm)
                gone()
            :quit -> :ok
        end
    end

    def gone() do
        receive do
            :return -> 
                available()
            :quit -> :ok
        end
    end

    def request(stick) do
        send(stick, {:request, self()})
        receive do
            :confirm -> :ok
        end
    end

    def return(stick) do
        send(stick, :return)
    end

    def terminate(stick) do
        send(stick, :quit)
    end
end

defmodule Philosopher do
    def start(hunger, right, left, name, ctrl) do
        spawn_link(fn -> think(hunger, right, left, name, ctrl) end)
    end

    def think(hunger, right, left, name, ctrl) do
        sleep(1000)
        eat(hunger, right, left, name, ctrl)
    end

    def eat(0, right, left, name, ctrl) do
        IO.puts("#{name} is full!")
        send(ctrl, :done)
        #sleep(1)
        #start(5, right, left, name, ctrl)
    end
    def eat(hunger, right, left, name, ctrl) do
        right_chopstick = Chopstick.request(right)
        sleep(100)
        left_chopstick = Chopstick.request(left)
        case right_chopstick do
            :ok ->
                IO.puts("#{name} received a right chopstick!")
                case left_chopstick do
                    :ok ->
                        IO.puts("#{name} received a left chopstick!")
                        IO.puts("#{name} is eating!")
                        sleep(hunger)
                end 
        end
        sleep(100)
        return_right_chopstick = Chopstick.return(right)
        return_left_chopstick = Chopstick.return(left)
        think(hunger - 1, right, left, name, ctrl)
    end

    def sleep(0) do
        :ok
    end
    def sleep(t) do
        :timer.sleep(:rand.uniform(t))
    end
end

defmodule Dinner do
    def start(), do: spawn(fn -> init() end)

    def init() do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    # Philosopher.start(n, 5, c1, c2, "Arendt", ctrl, seed + 1)
    # Philosopher.start(n, 5, c2, c3, "Hypatia", ctrl, seed + 2)
    # Philosopher.start(n, 5, c3, c4, "Simone", ctrl, seed + 3)
    # Philosopher.start(n, 5, c4, c5, "Elisabeth", ctrl, seed + 4)
    # Philosopher.start(n, 5, c1, c5, "Ayn", ctrl, seed + 5)
    Philosopher.start(5, c1, c2, "Arendt", ctrl)
    Philosopher.start(5, c2, c3, "Hypatia", ctrl)
    Philosopher.start(5, c3, c4, "Simone", ctrl)
    Philosopher.start(5, c4, c5, "Elisabeth", ctrl)
    Philosopher.start(5, c1, c5, "Ayn", ctrl)
    wait(5, [c1, c2, c3, c4, c5])
    end

    def wait(0, chopsticks) do
        Enum.each(chopsticks, fn(c) -> Chopstick.terminate(c) end)
    end

    def wait(n, chopsticks) do
        receive do
            :done ->
                wait(n - 1, chopsticks)
            :abort ->
                Process.exit(self(), :kill)
        end
    end
end