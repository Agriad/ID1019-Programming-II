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
                [head | [head | duplicate(tail)]]
        end
    end

    def duplicate_1([head | tail], []) do 
        duplicate_1(tail, [head, head])
    end

    def duplicate_1([head | tail], dList) do 
        duplicate_1(tail, dList ++ [head, head])
    end
    def duplicate_1([], dList) do 
        dList
    end

    def duplicate_2(list) do
        duplicate_2(list, [])
    end

    def duplicate_2([head|tail], list) do
        duplicate_2(tail, list++[head, head])
    end

    def duplicate_2([], list) do
        list
    end

    def duplicate_3(l) do
        [h|t] = l
        case t do
            [] -> [h, h]
            _ -> [h, h] ++ duplicate_3(t)
        end    
    end

    def add(element, list) do
        cond do
            list === [] -> []
            true -> [h | t] = list
                cond do
                    h === element -> list
                    true -> [h] ++ add(element, t, false)
                    # true -> [h | add(element, t, false)] also works
                end
        end
    end

    def add(element, list, boolean) do
        cond do
            boolean === true -> []
            true ->
                cond do
                    list === [] -> element
                    true ->
                        [h | t] = list
                        if h === element do
                            [h | add(element, t, true)]
                        else
                            [h] ++ [add(element, t, false)]
                        end
                end
        end
    end

    def remove(_, []) do
        []
    end

    def remove(element, list) do
        [h | t] = list
        cond do
            element === h -> remove(element, t)
            true -> [h | remove(element, t)]    
        end
        #case h do
        #    element -> remove(element, t)
        #    _ -> [h | remove(element, t)]
        #end
    end

    def reverse(list) do
        case list do
            [] -> list
            _ -> 
                [h | t] = list
                reverse(t) ++ [h]
        end
    end
end
