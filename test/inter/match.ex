defmodule Match do
    
#Evaluate Matching

    def eval_match(:ignore, _, env) do {:ok, env} end
    def eval_match({:atm, id}, id, env) do {:ok, env} end

    def eval_match({:var, id}, str, env) do
        case Env.lookup(id, env) do
            nil -> {:ok, Env.add(id, str, env)}
            {_, ^str} -> {:ok, env}
            {_, _} -> :fail
        end
    end

    def eval_match({:cons, hp, tp}, {hp2, tp2}  ,env) do
        case eval_match(hp, hp2, tp2) do
            :fail -> :fail
            {:ok, env} -> eval_match(tp, tp2, env)
        end
    end

    def eval_match(_, _, _) do :fail end
    



end