defmodule Vector do
    def smul({:vector, x1, x2, x3}, s) do
        {:vector, x1 * s, x2 * s, x3 * s}
    end

    def sub({:vector, x1, x2, x3}, {:vector, y1, y2, y3}) do 
        {:vector, x1 - y1, x2 - y2, x3 - y3}
    end

    def add({:vector, x1, x2, x3}, {:vector, y1, y2, y3}) do 
        {:vector, x1 + y1, x2 + y2, x3 + y3}
    end

    def dot({:vector, x1, x2, x3}, {:vector, y1, y2, y3}) do 
        {:number, x1 * y1 + x2 * y2 + x3 * y3}
    end  

    def normalize(x) do 
        {:number, length} = norm(x)
        {:vector, x1, x2, x3} = x
        {:vector, x1 / length, x2 / length, x3 / length}
    end

    def norm({:vector, x1, x2, x3}) do 
        {:number, :math.sqrt(x1 * x1 + x2 * x2 + x3 * x3)}
    end
end

defmodule Ray do
    require Record

    Record.defrecord(:ray, pos: {:pos, 0, 0, 0}, dir: {:vector, 1, 1, 1})

    # def ray(pos: pos, dir: dir) do
    #     {:ray, pos: pos, dir: dir}
    # end

    # def ray(ray, :pos) do
    #     (:ray, pos, dir) = ray
    #     pos
    # end

    # def ray(ray, :dir) do
    #     (:ray, pos, dir) = ray
    #     dir
    # end
end

defprotocol Object do
    def intersect(object, ray) do
        
    end
end

defmodule Sphere do
    defstruct pos: {:pos, 0, 0, 0}, radius: 2 
end

defimpl Object do
    def intersect(sphere = %Sphere{}, ray = %Ray{}) do
        distance = sphere.pos
    end
end