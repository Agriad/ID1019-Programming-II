defmodule Chopstick do
    def start do
        stick = spawn_link(fn -> available() end)
    end

    def available() do
        receive do
            {:request, from} -> ...
            :quit -> :ok
        end
    end

    def gone() do
        receive do
            {:request, _} -> available()
            :quit -> :ok
        end
    end 

    def request(stick) do
        send(stick, ...)
        receive do
            ... -> :ok
        end
    end

    def return(stick) do
        receive do
            {:message_type, value} ->
        end
    end

    def terminate(stick) do
        receive do
            {:message_type, value} ->
            # code
        end
    end
end

defmodule Philosopher do
    def start(name, hunger, right, left, ctrl) do
        
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
    Philosopher.start(n, 5, c1, c2, "Arendt", ctrl, seed + 1)
    Philosopher.start(n, 5, c2, c3, "Hypatia", ctrl, seed + 2)
    Philosopher.start(n, 5, c3, c4, "Simone", ctrl, seed + 3)
    Philosopher.start(n, 5, c4, c5, "Elisabeth", ctrl, seed + 4)
    Philosopher.start(n, 5, c1, c5, "Ayn", ctrl, seed + 5)
    wait(5, [c1, c2, c3, c4, c5])
    end

    def wait(0, chopsticks) do
        Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
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