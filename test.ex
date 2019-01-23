# test.ex
defmodule Test do
    def test(x) do
        case x do
            x > 5 -> 1
            x =< 5 -> 0   
        end
    end
end
