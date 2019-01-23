defmodule Sort do
    def insert(element, []) do
        [element]
    end

    def insert(element, list) do
        [head | tail] = list
        cond do
            element < head -> [element] ++ list
            element > head -> [head] ++ insert(element, tail)    
        end
    end

    def isort(l) do 
        isort(l, [])
    end

    def isort(x, l) do
        case x do
            [] -> 
                l
            [h | t] when h < x ->
                isort(t, insert(h, l))
            [h | t] ->
                isort(t, insert(h, l))
        end
    end

    def insert_sort(l) do
        insert_sort(l, [])
    end
    def insert_sort([], sort) do
        sort
    end
    def insert_sort(l, sort) do
        [head | tail] = l
        insert_sort(tail, insert(head, sort))
    end

    def insort(l) do
        insort(l, [])
    end

    def insort([head|tail], list) do
        list = insert(head,list)
        insort(tail, list)
    end

    def insort([], list) do
        list
    end

    def msort(l) do
        case ...  do
            ... -> 
                ...
            ... ->
                {split1, split2} = msplit(l, [], [])
            merge(msort(split1), msort(split2))
        end
    end

    def merge([], l) do l end
    def merge(l, []) do l end
    def merge([head1 | tail1], [head2 | tail2]) do
        if head1 < head2
            merge([head1 | tail1], [head2 | tail2])
        else 
            merge([head2 | tail2], [head1 | tail1])
        end
    end

    def msplit(split1, split2, split3) do
        case split1 do
        [] -> 
            {split2, split3}
        _ ->
            msplit(..., ..., ...)
        end
    end

end