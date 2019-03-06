defmodule Test do
    def once([]) do
        {0, 0}
    end
    def once(list) do
        [h | t] = list
        once(t, {h, 1})
    end
    def once([], ans) do
        ans
    end
    def once([h | t], {sum, len}) do
        once(t, {sum + h, len + 1})
    end
    # [1, 2, 3, 4, 5, 6, 7]

    def ack(0, n) do
        n + 1
    end
    def ack(m, 0) when m > 0 do
        ack(m - 1, 1)
    end
    def ack(m, n) when m > 0 and n > 0 do
        ack(m - 1, ack(m, n - 1))
    end

    def eval([h, '+' | t]) do
        h + eval(t)
    end
    def eval([h, '-' | t]) do
        h - eval(t)
    end
    def eval([num]) do
        num
    end
    # [5, '+', 2, '-', 3, '+', 10]

    def eval1(list) do
        eval1(list, 0)
    end
    def eval1([], total) do
        total
    end
    def eval1(['+', n2 | t], total) do
        eval1(t, total + n2)
    end
    def eval1(['-', n2 | t], total) do
        eval1(t, total - n2)
    end
    def eval1([h | t], total) do
        eval1(t, h)
    end
    # [5, '+', 2, '-', 3, '+', 10]

    def iso({:node, _, nil, nil}) do
        :true
    end
    def iso({:node, _, nil, _}) do
        :false
    end
    def iso({:node, _, _, nil}) do
        :false
    end
    def iso({:node, _, left, right}) do
        eval_left = iso(left)
        eval_right = iso(right)
        cond do
            eval_left == eval_right ->
                :true
            true ->
                :false
        end
    end
    # {:node, 1, {:node, 2, nil, nil}, {:node, 3, nil, nil}}
    # {:node, 1, {:node, 2, nil, nil}, nil}
end
# c("exam_2016_06_10.ex")