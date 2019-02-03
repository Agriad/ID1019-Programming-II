defmodule Env do
@doc """
Functions related to the environment of the intepreter.
The environment is represented as a list of tuples. Where the tuples contain a key and value of variable and value.
"""

    @doc """
    Creates a new environment that is empty.
    """
    def new() do
        []
    end

    @doc """
    Adds the id = variable and the str = structure into the environment.
    ex: [{:x, 1}]
    add(atom, atom / value, list)
    """
    def add(id, str, env) do
        [{id, str} | env]
    end

    @doc """
    Searches for the value of an id = variable. If found return the str = structure else it would return nil.
    lookup(atom, list)
    """
    def lookup(_, []) do
        nil
    end
    def lookup(id, env) do
        [head | tail] = env
        {a , _} = head
        cond do
            id === a -> head
            true -> lookup(id, tail)
        end
    end

    @doc """
    Finds the id = variable in the environment and removes it.
    remove(atom, list)
    """
    def remove(_, []) do
        []
    end
    def remove(ids, env) do
        [head | tail] = env
        {a, _} = head
        cond do
            ids === a -> tail
            true -> remove(ids, tail, [head])
        end
    end
    def remove(_, [], result) do
        result
    end
    def remove(ids, [head | tail], result) do
        {a, _} = head
        cond do
            ids === a -> result ++ tail
            true -> remove(ids, tail, [head] ++ result)
        end
    end
end