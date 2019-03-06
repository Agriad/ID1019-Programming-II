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
        :ok
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
                :ok
            true ->
                :false
        end
    end
    # {:node, 1, {:node, 2, nil, nil}, {:node, 3, nil, nil}}
    # {:node, 1, {:node, 2, nil, nil}, nil}

    def isomorfic(tree1, tree2) do
        case iso(tree1) do
            :ok ->
                case iso(tree2) do
                    :ok ->
                        :true
                    :false ->
                        :false
                end  
            :false ->
                :false  
        end
    end

    def foldp([elem], _) do
        elem
    end
    def foldp(list, function) do
        {list1, list2} = split(list, [], [])
        self = self()
        spawn_link(fn() -> elem = foldp(list1, function); send(self, {:ok, elem}) end)
        spawn_link(fn() -> elem = foldp(list2, function)
             send(self, {:ok, elem}) end)
        receive do
            {:ok, element1} ->
                receive do
                    {:ok, element2} ->
                        IO.puts element1
                        IO.puts element2
                        function.(element1, element2)
                end
        end
    end

    def split([], list1, list2) do
        {list1, list2}
    end
    def split([elem], list1, list2) do
        {[elem | list1], list2}
    end
    def split([h1, h2| t], list1, list2) do
        split(t, [h1 | list1], [h2 | list2])
    end
    # [1, 2, 3, 4, 5, 6, 7, 8] fn(x, y) -> x + y end

    def test(x), do: x
end
# c("exam_2016_06_10.ex")