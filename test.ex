# test.ex
defmodule Test do
    def test(a, n) do
        case a do
            n -> "is n"
            _ -> "not n"    
        end
    end
end
