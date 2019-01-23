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
        case length(l) do
            len when len < 2 -> 
                # IO.puts "msort1" 
                l    
            _ ->
                # IO.puts "msort2"
                {split1, split2} = msplit(l, [], [])
                # IO.puts split1
                # IO.puts split2
                merge(msort(split1), msort(split2))
        end
    end

    def merge([], l) do l end
    def merge(l, []) do l end
    def merge(list1, list2) do
        [head1 | tail1] = list1
        [head2 | tail2] = list2
        if head1 < head2 do
            # IO.puts "merge1"
            # merge(list1 ++ list2, [])
            # new_list = [head1 | head2]
            [head1] ++ merge(tail1, list2)
        else 
            # IO.puts "merge2"
            [head2] ++ merge(list1, tail2)
        end
    end

    def msplit(list, split1, split2) do
        case length(list) do
        len when len < 2 -> 
            # IO.puts "msplit1"
            {split1, list ++ split2}
        _ ->
            # IO.puts "msplit2"
            [head | tail] = list
            [head1 | tail1] = tail
            msplit(tail1, [head | split1], [head1 | split2])
        end
    end

end