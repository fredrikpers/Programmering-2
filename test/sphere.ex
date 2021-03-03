defmodule Sphere do
    
    defstruct pos: {0, 0, 0}, radius: 2

    defimpl Object do
        def intersect(sphere, ray) do
            k = Vector.sub(sphere.pos, ray.pos)
            a = Vector.dot(ray.dir, k)
            a2 = :math.pow(a, 2)
            k2 = :math.pow(Vector.norm(k), 2)
            r2 = :math.pow(sphere.radius, 2)
            t2 = a2 -k2 +r2
            closest(t2, a)
        end 
    end

end