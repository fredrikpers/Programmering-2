defmodule High do
    
    def map([], _) do [] end
    def map([head | tail ], op) do [op.(head) | map(tail, op)] end

end