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

    def sum_p(nil) do
        0
    end
    def sum_p(tree) do
        {:node, element, left, right} = tree
        self = self()
        id1 = spawn_link(fn() -> sum_p(left, self) end)
        # spawn(fn -> id1 = sum_p(left); send(self(), id1)
        id2 = spawn_link(fn() -> sum_p(right, self) end)
        total = element
        IO.puts "root #{element}" 
        receive do
            {:sum, number} ->
                IO.puts "first response"
                total = number + total
                receive do
                    {:sum, number} ->
                        IO.puts "second response"
                        total = number + total
                end
        end
    end
    def sum_p(nil, id) do
        IO.puts 0
        send(id, {:sum, 0})
    end
    def sum_p(tree, id) do
        number = sum_p(tree)
        IO.puts number
        send(id, {:sum, number})
    end
    # {:node, 1, {:node, 2, {:node, 4, nil, nil}, {:node, 5, nil, nil}}, {:node, 3, {:node, 6, nil, nil}, {:node, 7, nil, nil}}}
    # {:node, 1, {:node, 2, nil, nil}, {:node, 3, nil, nil}}
    # {:node, 1, nil, nil}

    def sum_p2(tree) do
        IO.puts "one"
        {:node, left, right} = tree
        self = self()
        spawn_link(fn() -> sum_p2(left, self) end)
        spawn_link(fn() -> sum_p2(right, self) end)
        receive do
            {:sum, number1} ->
                IO.puts "receive 1"
                receive do
                    {:sum, number2} ->
                        IO.puts "receive 2"
                        number2 + number1
                end
        end
    end
    def sum_p2({:node, _, _} = tree, id) do
        IO.puts "two"
        number = sum_p2(tree)
        send(id, {:sum, number})
    end
    def sum_p2(number, id) do
        IO.puts "three"
        send(id, {:sum, number})
    end
    # {:node, {:node, 4, 5}, {:node, 6, 7}}

    def sum_p3({:node, left, right}) do
        IO.puts "first"
        id1 = spawn_link(sum_p3(left))
        id2 = spawn_link(sum_p3(right))
        self = self()
        send(id1, {:calc, self})
        send(id2, {:calc, self})
        receive do
            {:ok, integer1} ->
                IO.puts "receive first"
                receive do
                    {:ok, integer2} ->
                        IO.puts "receive second"
                        receive do
                            {:calc, id} ->
                                IO.puts "receive third"
                                send(id, {:ok, integer1 + integer2})
                        end
                end
        end
    end
    def sum_p3(integer) do
        IO.puts "second"
        receive do
            {:calc, id} ->
                send(id, {:ok, integer})
        end
    end

    def sum_p4({:node, left, right}) do
        self = self()
        spawn(fn() ->  n = sum_p4(left)
                        send(self, n)
                        end
        )
        spawn(fn() -> n = sum_p4(right)
                      send(self, n)  
                      end
        )

        receive do
            n1 -> 
                receive do
                    n2 -> 
                        n1+n2
                end
        end
    end

    def sum_p4({:leaf, val}) do
        val
    end
    # {:node, {:node, {:leaf, 4}, {:leaf, 5}}, {:node, {:leaf, 6}, {:leaf, 7}}}
end
# c("example_exam.ex")