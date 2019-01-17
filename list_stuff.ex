defmodule ListStuff do
    def len(x) do
        cond do
            x === [] -> 0
            true -> 
                [head | tail] = x # can replace head with _
                len(tail, 0)
        end
    end

    def len(x, counter) do
        new_counter = counter + 1 # counter can be replaced with
        cond do
            x === [] -> new_counter
            # x == nil -> new_counter (this fails)
            true -> 
                [head | tail] = x
                len(tail, new_counter)
        end
    end

    def sum(x) do
        cond do
            x === [] -> 0
            true -> 
                [head | tail] = x
                head + sum(tail)
        end
    end

    def duplicate(x) do
        cond do
            x === [] -> x
            true ->
                [head | tail] = x
                duplicate(tail)
                tail ++ x
        end
    end
end