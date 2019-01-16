# currently not fibonacci
defmodule Fibo do
    def count(x, y) when 0 > x do
    IO.puts y
    end

    def count(x) do
    start = 1
    count(x - 1 , start)
    end

    def count(x, y) do
    IO.puts y
    count(x - 1, y + y)
    end
end