# test.ex
defmodule Test do
    def test() do
        test = start()
        send(test, {:hello, "onion"})
    end

    def start() do
        pid = spawn(fn -> process() end)
    end

    def process() do
        receive do
            {:hello, value} -> "yo"
            # code
        end
        
    end
end
