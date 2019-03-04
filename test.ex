defmodule Test do
    def start() do
        id = spawn(fn() -> memory_1() end)
    end

    def memory_1() do
        receive do
            {:set, new} ->
                memory_2(new)
            {:quit} ->
                :ok
        end
        
    end

    def memory_2(data) do
        receive do
            {:swap, new, from} ->
                send(from, {:ok, data})
                memory_2(new)
            {:quit} ->
                :ok
        end
    end

    def change(id, data) do
        my_id = self()
        send(id, {:swap, data, my_id})
        receive do
            {:ok, data} -> data
        end
    end
end