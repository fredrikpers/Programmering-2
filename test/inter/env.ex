defmodule Env do
    
    #New empty environment
    def new() do [] end

    #Add to environment
    def add(id, str, env) do [ {id, str} | env] end

    #Find {id, str} pair
    def lookup(_, []) do :nil end
    def lookup(id, [{id, str} | _]) do {id,str} end
    def lookup(id, [_ | tail]) do lookup(id, tail) end

    #Remove all ids from the environment
    def remove(_, []) do [] end
    def remove(ids, [{ids, _str} | tail]) do remove(ids, tail) end
    def remove(ids, [{id, str} | tail]) do [{id,str} | remove(ids, tail)] end

    #Closure
    def closure(free, env) do
       


       
    end

end