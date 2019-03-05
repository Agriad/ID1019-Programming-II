defmodule Test do
    def reduce(list) do
        [h | t] = list
        reduce(h, t, [h])
    end
    def reduce(_, [], done) do
        Enum.reverse(done)
    end
    def reduce(check, list, done) do
        [h | t] = list
        cond do
            check === h -> reduce(h, t, done)
            true -> reduce(h, t, [h | done])
        end
    end
    # [1, 2, 2, 3, 1, 2, 4, 4, 4, 2, 3, 3, 1]

    def encode(string) do
        charlist = String.to_charlist(string)
        encode(charlist, [])
    end
    def encode([], done) do
        Enum.reverse(done)
    end
    def encode(charlist, done) do
        [h | t] = charlist
        new_code = h - 3
        cond do
            h === 32 ->
                encode(t, [32 | done])
            new_code < 97 ->
                difference = 97 - new_code
                # encode(t, [122 - difference | done])
                encode(t, [123 - difference | done])
            true ->
                encode(t, [new_code | done])
        end
    end
    # encoded you are

    def triss([]) do
        :false
    end
    def triss(hand) do
        [h | t] = hand
        {:card, _, number} = h
        check = Enum.filter(hand, 
            fn({:card, _, x}) -> x === number end
        )
        IO.inspect check
        length = Kernel.length(check)
        cond do
            length >= 3 -> :true
            true -> triss(t)
        end
    end
    # {:card, :diamond, 5}, {:card, :diamond, 4}, {:card, :diamond, 3}
    # [{:card, :diamond, 5}, {:card, :diamond, 5}, {:card, :diamond, 5}, {:card, :diamond, 4}, {:card, :diamond, 4}]
    # [{:card, :diamond, 5}, {:card, :diamond, 5}, {:card, :diamond, 3}, {:card, :diamond, 4}, {:card, :diamond, 4}]

    def merge(list1, list2) do
        merge(list1, list2, [])
    end
    def merge([], list2, done) do
        Enum.reverse(done) ++ list2
    end
    def merge(list1, [], done) do
        Enum.reverse(done) ++ list1
    end
    def merge(list1, list2, done) do
        [h1 | t1] = list1
        [h2 | t2] = list2
        cond do
            h1 < h2 ->
                merge(t1, list2, [h1 | done])
            h2 < h1 ->
                merge(list1, t2, [h2 | done])
            true ->
                merge(t1, list2, [h1 | done])
        end
    end
    # [1, 3, 5] [2, 4, 6]
    # [1, 3, 4, 5] [2, 6, 7]

    def heap_to_list(:nil, done) do
        Enum.reverse(done)
        #done
    end
    def heap_to_list(tree, done) do
        {:node, element, left, right} = tree
        list = heap_to_list(left, [element | done])
        other_list = heap_to_list(right, [])
        merge_h(list, other_list, [])
    end

    def merge_h([], r_list, done) do
        Enum.reverse(done) ++ r_list
    end
    def merge_h(l_list, [], done) do
        Enum.reverse(done) ++ l_list
    end
    def merge_h(l_list, r_list, done) do
        [lh | lt] = l_list
        [rh | rt] = r_list
        cond do
            lh <= rh ->
                merge(lt, r_list, [lh | done])
            true ->
                merge(l_list, rt, [rh | done])
        end
    end
    # {:node, 1, ,} ,{:node, 2, ,}, {:node, 3, ,}, {:node, 4, ,}, {:node, 5, ,}
    # {:node, 1, ,} ,{:node, 2, :nil,}, {:node, 3, , :nil}, {:node, 4, :nil, :nil}, {:node, 5, :nil, :nil}
    # {:node, 1, {:node, 2, :nil, {:node, 5, :nil, :nil}}, {:node, 3, {:node, 4, :nil, :nil}, :nil}}

    def pop(:nil) do
        :false
    end
    def pop(tree) do
        {:node, element, left, right} = tree
        cond do
            left === :nil && right === :nil ->
                {:ok, element, :nil}
            left === :nil ->
                {:ok, element, right}
            right === :nil ->
                {:ok, element, left}
            true ->
                {:ok, element_l, tree_l} = pop(left)
                {:ok, element_r, tree_r} = pop(right)
                cond do
                    element_l <= element_r ->
                        new_tree = {:node, element_l, tree_l, right}
                        {:ok, element, new_tree}
                    true ->
                        new_tree = {:node, element_r, left, element_r}
                        {:ok, element, new_tree}
                end
        end
    end
    # {:node, 1, ,} ,{:node, 2, ,}, {:node, 3, ,}, {:node, 4, ,}, {:node, 5, ,}, {:node, 6, ,}, {:node, 7, ,}, {:node, 8, ,}
    # {:node, 9, ,}, {:node, 10, ,}, {:node, 11, ,}, {:node, 12, ,}, {:node, 13, ,}, {:node, 14, ,}, {:node, 15, ,}
    #
    # {:node, 1, ,} ,{:node, 2, ,}, {:node, 3, ,}, {:node, 4, ,}, {:node, 5, ,}, {:node, 6, ,}, {:node, 7, ,}, {:node, 8, :nil, :nil}
    # {:node, 9, :nil, :nil}, {:node, 10, :nil, :nil}, {:node, 11, :nil, :nil}
    # {:node, 12, :nil, :nil}, {:node, 13, :nil, :nil}, {:node, 14, :nil, :nil}, {:node, 15, :nil, :nil}
    # 
    # {:node, 1, ,} ,{:node, 2, ,}, {:node, 3, ,}, {:node, 4, ,}, {:node, 5, ,}, {:node, 6, ,}, {:node, 7, ,}, {:node, 8, :nil, :nil}
    # {:node, 9, :nil, :nil}, {:node, 10, :nil, :nil}, {:node, 11, :nil, :nil}
    # {:node, 12, :nil, :nil}, {:node, 13, :nil, :nil}, {:node, 14, :nil, :nil}, {:node, 15, :nil, :nil}

    def start(data) do
        id = spawn(fn() -> memory() end)
        send(id, {:set, data})
        id
    end

    def memory() do
        receive do
            {:set, new} ->
                memory(new)
        end
    end
    def memory(data) do
        receive do
            {:swap, new, from} ->
                send(from, {:ok, data})
                memory(new)
            {:quit} ->
                IO.formats "process terminated"
                :ok
        end
    end

    def memory_test(id, data) do
        send(id, {:swap, data, self()})
        receive do
            {:ok, data} ->
                data
        end
    end
end

# c("exam_2016_03_19.ex")