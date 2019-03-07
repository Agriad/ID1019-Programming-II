defmodule Test do
    def freq(key, []) do
        []
    end
    def freq(key, [{key, n} | t]) do
        [{key, n + 1} | t]
    end
    def freq(key, [h | t]) do
        [h |  freq(key, t)]
    end
    # :a
    # [{:a, 1}, {:b, 1}, {:c, 2}]

    def fraq([], freq) do
        freq
    end
    def fraq([h | t], freq) do
        fraq(t, freq(h, freq))
    end
    # wrong
    # [:a, :b, :c]
    # [{:a, 1}, {:b, 1}, {:c, 2}]
end
# c("exam_2017_03_13.ex")