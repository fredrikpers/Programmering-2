defmodule Eager do

#Evaluate Expressions
    def eval_expr({:atm, id}, _) do {:ok, id} end        
    def eval_expr({:var, id}, env) do 
        case Env.lookup(id, env) do
            nil -> :error
            {_,str} -> {:ok, str}
        end
    end        

    def eval_expr({:cons, var, atm}, env) do
        case eval_expr(var, env) do
            :error -> :error
            {:ok, str} ->
                case eval_expr(atm, env) do
                    :error -> :error
                    {:ok, ts} -> {:ok, {str,  ts}}
                end
        end
    end

    def eval_expr({:case, expr, cls}, env) do
        case eval_expr(expr, env) do
            :error -> :error
            {:ok, str} -> eval_cls(cls, str, env)
        end
    end

    def eval_expr({:lambda, par, free, seq}, env) do
        case Env.closure(free, env) do
            :error -> :error
            closure -> {:ok {:closure, par, seq, env}}
        end
    end

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
        case eval_match(hp, hp2, env) do
            :fail -> :fail
            {:ok, env} -> eval_match(tp, tp2, env)
        end
    end

    def eval_match(_, _, _) do :fail end

# Evaluate Sequence

    def eval(seq) do eval_seq(seq, Env.new()) end

    def extract_vars(pattern) do extract_vars(pattern, []) end
    def extract_vars({:atm, _}, pattern) do pattern end
    def extract_vars(:ignore, pattern) do pattern end
    def extract_vars({:var, var}, pattern) do [var | pattern] end
    def extract_vars({:cons, head, tail}, pattern) do
        extract_vars(tail, extract_vars(head, pattern)) 
    end

    def eval_scope(ptr, env) do
        Env.remove(extract_vars(ptr), env)
    end

    def eval_seq([exp], env) do
        eval_expr(exp, env)
    end

    def eval_seq([{:match, ptr, exp} | rest], env) do
        case eval_expr(exp, env) do
            :error -> :error
            {:ok, str} -> env = eval_scope(ptr, env)

            case eval_match(ptr, str, env) do
                :fail -> :error
                {:ok, env} -> eval_seq(rest, env)
            end
        end
    end

#Clause

    def eval_cls([], _, _, _) do :error end

    def eval_cls([{:clause, ptr, seq} | cls], str, env) do 

        env = eval_scope(ptr, env)

        case eval_match(ptr, str, env) do
            :fail -> eval_cls(cls, str, env)
            {:ok, env} -> eval_seq(seq , env)
        end
     end

end