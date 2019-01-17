# test.ex
defmodule Test do
    def duplicate(x) do
        duplicate(x)
        [head | tail] = x
        [head | x]
    end
end