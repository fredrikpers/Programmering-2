defmodule High do

    def map([], _) do [] end    
    def map([h | t], op) do [op.(h) | map(t, op)] end   
    
     
end