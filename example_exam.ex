defmodule Test do
    def double_even([], done) do
        Enum.reverse(done)
    end
    def double_even(list, done) do
        [h | t] = list
        case rem(h, 2) do
            1 ->
                double_even(t, [h | done])
            0 ->
                double_even(t, [h | [h | done]])
        end
    end
    # [1, 2, 3, 4, 5, 6]

    def sum(nil) do
        nil
    end
    def sum(tree) do
        sum(tree, 0)
    end

    def sum(nil, sum) do
        sum
    end
    def sum(tree, sum) do
        {:node, element, left, right} = tree
        sum_l = sum(left, element + sum)
        sum_r = sum(right, sum_l)
        # sum_r = sum(right, 0)
        # sum_l + sum_r
    end
    # {:node, 1, ,}, {:node, 2, ,}, {:node, 3, ,}, {:node, 4, ,}, {:node, 5, ,}, {:node, 6, ,}, {:node, 7, ,}
    # {:node, 1, {:node, 2, {:node, 4, nil, nil}, {:node, 5, nil, nil}}, {:node, 3, {:node, 6, nil, nil}, {:node, 7, nil, nil}}}

    def mirror(nil) do
        nil
    end
    def mirror(tree) do
        {:node, element, left, right} = tree
        right_tree = mirror(left)
        left_tree = mirror(right)
        {:node, element, left_tree, right_tree}
    end
    # {:node, 1, {:node, 2, {:node, 4, nil, nil}, {:node, 5, nil, nil}}, {:node, 3, {:node, 6, nil, nil}, {:node, 7, nil, nil}}}

    def add(nil, element) do
        {:node, element, nil, nil}
    end
    def add(tree, element) do
        {:node, number, left, right} = tree
        cond do
            element > number ->
                left_heap = add(right, element)
                {:node, number, left_heap, left}
            nil === right ->
                # {:node, element, number, nil}
                {:node, element, tree, nil}
            {:node, number_2, left_2, right_2} = right ->
                {:node, element, right, left_2}
        end
    end
    # {:node, 1, {:node, 4, nil, nil}, {:node, 6, nil, nil}}

    def fizzbuzz(n) do
        fizzbuzz(1, n + 1, 1, 1)
    end

    def fizzbuzz(counter, ending, counter_f, counter_b) do
        cond do
            counter === ending ->
                []
            counter_f === 3 && counter_b === 5 ->
                # [counter | fizzbuzz(counter + 1, ending, 0, 0)]
                [:fizzbuzz | fizzbuzz(counter + 1, ending, 1, 1)]
            counter_f === 3 ->
                # [counter | fizzbuzz(counter + 1, ending, 0, counter_b + 1)]
                [:fizz | fizzbuzz(counter + 1, ending, 1, counter_b + 1)]
            counter_b === 5 ->
                # [counter | fizzbuzz(counter + 1, ending, counter_f + 1, 0)]
                [:buzz | fizzbuzz(counter + 1, ending, counter_f + 1, 1)]
            true ->
                [counter | fizzbuzz(counter + 1, ending, counter_f + 1, counter_b + 1)]
        end
    end
end
# c("example_exam.ex")