defmodule Test do
    def sum(tree) do
        sum(tree, 0)
    end
    def sum(nil, sum) do
        0
    end
    def sum({:node, integer, left, right}, sum) do
        sum + sum(left, 0) + sum(right, 0) + integer
    end
    # {:node, 1, {:node, 2, :nil, {:node, 5, :nil, :nil}}, {:node, 3, {:node, 4, :nil, :nil}, :nil}}

    def reverse([h | t]) do
        reverse(t, [h])
    end
    def reverse([h]) do
        [h]
    end
    def reverse([], done) do
        done
    end
    def reverse([h | t], done) do
        reverse(t, [h | done])
    end
    # [1, 2, 3, 4, 5]

    def append(list1, list2) do
        append(reverse(list1), list2, 1)
    end
    def append([], done, 1) do
        done
    end
    def append([h | t], done, 1) do
        append(t, [h | done], 1)
    end
    # [1, 2, 3, 4, 5]
    # [6, 7, 8, 9, 10]

    def append1([], list2), do: list2
    def append1(list1, list2) do
        [h |t] = reverse(list1)
        append(reverse(t), [h | list2])
    end
    # [1, 2, 3, 4, 5]
    # [6, 7, 8, 9, 10]
end
# c("exam_2018_03_13.ex")