defmodule Recursion do
# base case. This case when x less than 0 print then stop
    def countdown(x) when x <= 0 do
    IO.puts x
    end

    def countdown(x) do
    IO.puts x 
    countdown(x - 1) # recursion part
    end

    @doc """
    Compute the product of a and b.
    """
    # def prod(a, b) do
    #     case a do
    #         0 -> 0
    #         _ -> b + prod(a - 1, b)
    #     end
    # end

    def prod(_, 0) do
        0
    end
    def prod(0, _) do
        0
    end
    def prod(a, b) do
        cond do
            a < 0 and b < 0 -> abs(a) + abs(prod(a, b + 1))
            a < 0 -> a + prod(a, b - 1)
            b < 0 -> b + prod(a - 1, b)
            true -> b + prod(a - 1, b)
        end
    end

    @doc """
    Compute a to the power of b.
    """
    def power(_, 0) do
        1
    end
    def power(a, b) when b > 0 do
        a * power(a, b - 1)
    end

    @doc """
    Compute a to the power of b in a faster way.
    """
    def qpower(a, b) do
        0 # not done
    end

    @doc """
    Translate decimal to binary
    """
    def binary(0) do
        []
    end

    def binary(a) do
        binary(div(a, 2)) ++ [rem(a, 2)]
    end

    @doc """
    Translate decimal to binary in a better way
    """
    def binary2(i) do
        binary2(i, [])
    end

    def binary2(0, sofar) do
        # Enum.reverse(sofar)
        sofar
    end

    def binary2(i, list) do
        binary2(div(i, 2), [rem(i, 2)] ++ list)
    end
end