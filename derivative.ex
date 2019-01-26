defmodule Derivative do
    def deriv({:const, _}, _) do
        # 0
        n1 = {:const, 0}
        {interpret(n1), n1}
    end
    def deriv({:var, v}, v) do
        # 1
        n1 = {:const, 1}
        {interpret(n1), n1}
    end
    def deriv({:var, y}, _) do
        # 0
        n1 = {:const, 0}
        {interpret(n1), n1}
    end
    def deriv({:mul, e1, e2}, v) do
        {_ , b1} = e1
        {_, b2} = e2
        # deriv(e1, v) * b2 + b1 * deriv(e2, v)
        {_, n1} = deriv(e1, v)
        {_, n2} = deriv(e2, v)
        # n1 = {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
        n3 = {:add, {:mul, n1, e2}, {:mul, e1, n2}}
        {interpret(n3), n3}
    end
    def deriv({:add, e1, e2}, v) do
        # deriv(e1, v) + deriv(e2, v)
        # {:add, deriv(e1, v), deriv(e2, v)}
        {_, n1} = deriv(e1, v)
        {_, n2} = deriv(e2, v)
        n3 = {:add, n1, n2}
        {interpret(n3), n3}
    end
    # {:add, {: , }, {: , }}
    def deriv({:pow, e1, e2}, v) do # redo so that it uses v
        #{:mul, e2, {:pow, e1, {:add, e2, {:const, -1}}}}
        {a, b} = e1
        {c, d} = e2
        if ((a === :var) and (b === v)) do
            n1 = {:mul, e2, {:pow, e1, {:add, e2, {:const, -1}}}}
            {interpret(n1), n1}
        else
            n1 = {:const, 0}
            {interpret(n1), n1}
        end
    end
    # 3 * (pow (var (2 * v ^ 1))) * 2
    def deriv({:ln, e1}, v) do
        {_, n1} = deriv(e1, v)
        # {:mul, deriv(e1, v), {:pow, e1 ,{:const, -1}}}
        n2 = {:mul, n1, {:pow, e1 ,{:const, -1}}}
        {interpret(n2), n2}
    end
    def deriv({:div, e1, e2}, v) do
        {a, b} = e1
        {c, d} = e2
        if (b === 1) and (d === v) do
            n1 = {:ln, e2}
            {interpret(n1), n1}
        else
            n1 = {:const, 0}
            {interpret(n1), n1}
        end
    end
    def deriv({:sqrt, e1}, v) do
        {_, n1} = deriv({:pow, e1, {:const, 0.5}}, v)
        {interpret(n1), n1}
    end
    def deriv({:sin, e1}, v) do
        {_, n1} = deriv(e1, v)
        # {:mul, deriv(e1, v), {:cos, e1}}
        n2 = {:mul, n1, {:cos, e1}}
        {interpret(n2), n2}
    end

    def interpret({:const, v}) do
        "#{v}"
    end
    def interpret({:var, v}) do
        "#{v}"
    end
    def interpret({:mul, a, b}) do
        n1 = interpret(a)
        n2 = interpret(b)
        "#{n1} * #{n2}"
    end
    def interpret({:add, a, b}) do
        n1 = interpret(a)
        n2 = interpret(b)
        "#{n1} + #{n2}"
    end
    def interpret({:pow, a, b}) do
        n1 = interpret(a)
        n2 = interpret(b)
        "#{n1}^#{n2}"
    end
    def interpret({:ln, a}) do
        n1 = interpret(a)
        "ln(#{n1})"
    end
    def interpret({:cos, a}) do
        n1 = interpret(a)
        "cos(#{n1})"
    end
end