defmodule Test do
    def create() do
        spawn(fn() -> lock_open() end)
    end

    def lock_open() do
        receive do
            {:lock, id} ->
                send(id, {:ok, :lock})
                lock_close()
        end
    end

    def lock_close() do
        receive do
            {:unlock, id} ->
                send(id, {:ok, :unlock})
                lock_open()
        end
    end

    def lock(id) do
        send(id, {:lock, self()})
        receive do
            {:ok, :lock} ->
                :ok
        end
    end

    def release(id) do
        send(id, {:unlock, self()})
        receive do
            {:ok, :unlock} ->
                :ok
        end
    end
end