defmodule Seq do
    
    def extract_vars(pattern) do extract_vars(pattern, []) end
    def extract_vars({:atm, var}, pattern) do  end


    def eval_scope(..., ... ) do
        Env.remove(extract_vars(...), ...)
    end

    def eval_seq([{:match, ..., ...} | ...], ...) do
        case eval_expr
    end
end