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

defmodule Eager do
@doc """
Evaluates the expressions
"""

    @doc """
    Evaluating an atom in any environment returns an ok and the atom id
    """
    def eval_expr({:atm, id}, _) do {:ok, id} end

    # def eval_expr({:var, id}, env) do
    #     case  do
    #         nil ->
    #             :error
    #         {_, str} ->
    #     end
    # end

    @doc """
    Evaluating a variable by checking through the environment to see if it exist.
    If it does return :ok and the value, else return :error
    """
    def eval_expr({:var, _}, []) do
        :error
    end
    def eval_expr({:var, id}, [head | tail]) do
        {id_env, val} = head
        cond do
            id === id_env -> {:ok, val}
            true -> eval_expr({:var, id}, tail)
        end
    end

    @doc """
    Evaluates a cons structure. First do the left part then if ok do the right part.
    Can be very deep depending on the input.
    Returns a tuple of the values
    """
    def eval_expr({:cons, head, tail}, env) do
        IO.puts "eval expr"
        case eval_expr(head, env) do
            :error ->
                :error
            {:ok, id} ->
                case eval_expr(tail, env) do
                    :error ->
                        :error
                    {:ok, ts} ->
                        {id, ts}
                end
        end
    end
@doc """
Evaluates a match to see if the environment needs to be extended
"""
    def eval_match(:ignore, _, env) do
        {:ok, env}
    end

    # wrong
    def eval_match({:atm, id}, _, env) do
        {:ok, env}
    end

    # correct
    def eval_match({:atm, id}, id, env) do
        {:ok, env}
    end

    # def eval_match({:var, id}, str, env) do
    #     case {:var, id} do
    #         nil ->
    #             {:ok, []}
    #         {_, ^str} ->
    #             {:ok, [{id, str} | env]}
    #         {_, _} ->
    #             :fail
    #     end
    # end

    # remember that you can use previous functions
    def eval_match({:var, id}, str, []) do
        {:ok, [{id, str}]}
    end
    def eval_match({:var, id}, str, env) do
        [env_head | env_tail] = env
        {env_id, env_str} = env_head
        cond do
            id === env_id && str === env_str -> {:ok, env}
            id === env_id -> :fail
            true -> eval_match({:var, id}, str, env_tail)
        end
    end

    def eval_match({:cons, hp, tp}, {:cons, {_, str_head}, {_, str_tail}}, env) do
        case ans = eval_match(hp, str_head, env) do
            :fail ->
                :fail
            _ ->
                {_, env_new} = ans
                case eval_match(tp, str_tail, env_new) do
                    :fail -> :fail
                    _ ->
                        {:ok, env_result} = eval_match(tp, str_tail, env_new)
                        {:ok, env_new ++ env_result}
                end
        end
    end

    def eval_match(_, _, _) do
        :fail
    end

    @doc """
    Evaluates an expression.
    """
    def eval_seq([exp], env) do
        eval_expr(exp, env)
    end

    def eval_seq([{:match, match_head, match_tail} | tail], env) do
        IO.puts "eval_seq"
        case eval_expr(match_head, env) do
            :error ->
                IO.puts "eval_seq case1, 1"
                :error
            _ ->
            IO.puts "eval_seq case1, 2"
            vars = extract_vars(match_head)
            env = Env.remove(vars, env)
            {_, tail_str} = match_tail
            case eval_match(vars, tail_str, env) do
                :fail ->
                    :error
                {:ok, env} ->
                    eval_seq(tail, env)
            end
        end
    end

    # def eval_seq([{:match, match_head, match_tail} | tail], env) do
    #     case eval_expr(match_tail, env) do
    #         :error ->
    #             IO.puts "test1"
    #             vars = extract_vars(match_head)
    #             {_, tail_str} = match_tail
    #             case eval_match(match_head, tail_str, env) do
    #                 :fail ->
    #                     :error
    #                 {:ok, env} ->
    #                     eval_seq(tail, env)
    #             end
    #         _ ->
    #             IO.puts "test2"
    #             vars = extract_vars(match_head)
    #             env = Env.remove(vars, env)
    #             {_, tail_str} = match_tail
    #             case eval_match(match_head, tail_str, env) do
    #                 :fail ->
    #                     IO.puts "test3"
    #                     :error
    #                 {:ok, env} ->
    #                     eval_seq(tail, env)
    #             end
    #     end
    # end

    # def eval_seq([{:match, match_head, match_tail} | tail], env) do
    #     case eval_expr(match_tail, env) do
    #         :error ->
    #             IO.puts "test1"
    #             :error
    #         _ ->
    #             IO.puts "test2"
    #             vars = extract_vars(match_head)
    #             env = Env.remove(vars, env)

    #             IO.puts Kernel.inspect match_head
    #             IO.puts Kernel.inspect match_tail
    #             case match_tail do
    #                 {_, str} -> 
    #                     {_, str} = match_tail
    #                     case out = eval_match(match_head, str, env) do # fail here maybe
    #                         :fail ->
    #                             IO.puts "test3"
    #                             :error
    #                         {:ok, env} ->
    #                             IO.puts "test4"
    #                             out
    #                             eval_seq(tail, env)
    #                     end
    #                 {_, _, _} ->
    #                     case out = eval_match(match_head, match_tail, env) do # fail here maybe
    #                         :fail ->
    #                             IO.puts "test3"
    #                             :error
    #                         {:ok, env} ->
    #                             IO.puts "test4"
    #                             out
    #                             eval_seq(tail, env)
    #                     end
    #             end
    #     end
    # end

    # def eval_seq([{:match, match_head, match_tail} | tail], env) do
    #     case eval_expr(match_tail, env) do
    #         :error ->
    #             :error
    #         _ ->
    #             vars = extract_vars(match_head)
    #             env = Env.remove(vars, ...)

    #             case eval_match(..., ..., ...) do
    #                 :fail ->
    #                 :error
    #                 {:ok, env} ->
    #                 eval_seq(..., ...)
    #             end
    #     end
    # end

    @doc """
    Extract the ids.
    """
    # need to extract everything and to try all cases. vaar, atm, etc
    def extract_vars({_, id}) do
        [id]
    end
    # def extract_vars({_, head, tail}) do
    #     result = extract_vars(head)
    #     result1 = extract_vars(head)
    #     cond do
    #         result === :fail && result1 === :fail -> :fail
    #         result === :fail -> 
    #         result1 === :fail ->
    #         true ->
    #     end
    # end
    # def extract_vars(_) do
    #     :fail
    # end

    def eval(seq) do
        env = Env.new()
        result = eval_seq(seq, env)
        case result do
            :error -> :error
            _ -> {:ok, result}
        end
        # {head | tail} = seq
        # eval_seq(head, tail, env, [])
    end
    # str = [{:x, :a}]
    # str = [{:y, {:cons, {:var, :x}, {:atm, :b}}}]
    # str = [{:z, :b}]
    # {:ok, str}, str = [{:x, :a}, {:y, }]
end

"""
seq = [{:match, {:var, :x}, {:atm,:a}},{:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},{:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},{:var, :z}]

seq = [{:match, {:var, :x}, {:atm,:a}}, {:var, :x}]
Eager.eval([{:match, {:var, :x}, {:atm,:a}}, {:var, :x}])

Eager.eval(seq)
"""
