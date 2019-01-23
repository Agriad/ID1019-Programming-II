defmodule Challenge do
    def to_binary(0) do
        []
    end

    def to_binary(x) do
        # append(rem(x, 2), to_binary(rem(x, 2)))
        to_binary(div(x, 2)) ++ [rem(x, 2)]
    end

    def to_better(n) do to_better(n, []) end

    def to_better(0, b) do b end

    def to_better(n, b) do
        to_better(div(n, 2), [rem(n, 2) | b])
    end

    def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
    end

    def to_integer(x) do to_integer(x, 0) end

    def to_integer([], n) do n end

    def to_integer([x | r], n) do
        to_integer(r, n + (x * (:math.pow(2, length(r)))))
    end
end