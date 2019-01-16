defmodule Math do
    def area_rectangle(b, h) do
    b * h
    end

    def area_square(s) do
    area_rectangle(s, s)
    end

    def area_circle(r) do
    :math.pow(r, 2) * :math.pi
    end

    def product(m, n) do
        cond do
            m == 0 -> m
            m != 0 -> n + product(m - 1, n)
        end
    end

    def exp_2(x) do
        product(x, x)
    end

    def exp(x, n) do
        case n do
            1 -> x
            _ ->
                case rem(n, 2) do
                0 -> exp(x, div(n, 2)) * exp(x, div(n, 2))
                1 -> x * exp(x, n - 1)
                end
        end
    end
end