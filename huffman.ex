defmodule Huffman do
    def sample do
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end
    # [t, h, e,  , q, u, i, c, k,  , b,]

    def text()  do
        'this is something that we should encode'
    end

    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end

    def encode_table(tree) do
        encode_table_maker(tree)
    end

    def decode_table(tree) do
        # To implement...
    end

    def encode(text, table) do
        encoder(text, table)
    end

    def decode(seq, tree) do
        # To implement...
    end

    @doc """
    Takes in a text and returns a list of tuples that contains the frequency of the characters.
    """
    def freq(sample) do
        freq(sample, [])
    end
    def freq([], freq) do
        freq
    end
    def freq([char | rest], freq) do
        # freq ++ check(char, freq)
        # IO.puts "freq3"
        # freq(rest, freq)
        # freq(rest, freq ++ check(char, freq))
        freq(rest, check(char, freq))
    end

    @doc """
    takes in a character and checks with the list if it exist. If it does not exist than create a new entry,
    else updates the entry
    """
    def check(char, []) do # issue
        [{char, 1}]
    end
    def check(char, list) do
        [h1 | t1] = list
        {h2, t2} = h1
        cond do
            char === h2 -> [{h2, t2 + 1} | t1]
            true -> [h1] ++ check(char, t1)
        end
    end
    # [{a, 5}, {b, 10}, ...]

    @doc """
    Takes in a list of tuples of frequency counters and returns a sorted binary list in tuple form
    {a, b}, a = {a, b}, b = int
    """
    def huffman([a | []]) do
        a
    end
    def huffman(freq) do
        min = minimum(freq)
        freq1 = remove(freq, min)
        # {min, freq1}
        min1 = minimum(freq1)
        freq2 = remove(freq1, min1)
        {_, v1} = min
        {_, v2} = min1
        node = {{min, min1}, v1 + v2}
        # node = {min1, min2, v1 + v2}
        freq3 = [node] ++ freq2
        huffman(freq3)
    end
    # {{a, 5}, l} 
    # l = {{b, 3}, {d, 1}}

    @doc """
    Takes in a frequency list of tuples and finds the minimum occurance tuple and returns it.
    """
    def minimum(freq) do
        [h | t] = freq
        minimum(freq, h)
    end
    def minimum([], min) do
        min
    end
    def minimum(freq, min) do
        {h , t} = min
        [h2 | t2] = freq
        {h3 , t3} = h2
        cond do
            t <= t3 -> minimum(t2, min)
            t > t3 -> minimum(t2, h2)
        end
    end

    @doc """
    Remove the input from the list of occurances
    """
    def remove(freq, element) do
        remove(freq, element, [])
        # [h | t] = freq
        # if h === element do
        #     remove([], [], t)
        # else
        #     remove(t, element, [])
        # end
    end
    def remove([], [], finished) do
        finished
    end
    def remove(freq, element, finished) do
        [h | t] = freq
        if h === element do
            t ++ finished
        else
            remove(t, element, [h] ++ finished)
        end
    end

    @doc """
    Finds the characters / integers in the tree and determines the code it produces
    left is 0 right is 1
    """
    def encode_table_maker(tree) do
        {{left, right}, value} = tree
        list = encode_table_maker(left, [0], [])
        encode_table_maker(right, [1], list)
    end
    def encode_table_maker({{left, right}, value}, code, list) do
        new_list = encode_table_maker(left, code ++ [0], list)
        encode_table_maker(right, code ++ [1], new_list)
    end
    def encode_table_maker({element, value}, code, []) do
        {element, code}
    end
    def encode_table_maker({element, value}, code, list) do
        [list | [{element, code}]]
    end

    @doc """
    Uses the encode table to encode a message
    returns a list of the encoded message in binary
    """
    def encoder do
        
    end
end