defmodule Recursion do
# base case. This case when x less than 0 print then stop
    def countdown(x) when x <= 0 do
    IO.puts x
    end

    def countdown(x) do
    IO.puts x 
    countdown(x - 1) # recursion part
    end
end