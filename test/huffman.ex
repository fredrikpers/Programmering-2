defmodule Huffman do
    
    def sample do
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end

    def text() do
       'this is something that we should encode'
    end
    
    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table_better(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end

#CREATE TABLE

    def freq(sample) do
        freq(sample, [])
    end

    def freq([], freq) do
        freq
    end

    def freq([char | rest], freq) do
        freq(rest, update(char, freq))
    end

    def update(char, [] ) do
        [{char, 1}]
    end

    def update(char, [{char, n} | tail]) do
        [{char, n + 1} | tail]
    end

    def update(char, [head | tail]) do
        [ head | update(char, tail)]        
    end

    def huffman(freq) do
        sorted = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
        create_tree(sorted)
    end

#CREATE TREE

    def create_tree([{tree, _}]) do tree end

    def create_tree([{char1, freq1}, {char2, freq2} | rest]) do
       create_tree(insert( { { char1 , char2 } , freq1 + freq2 }, rest ) ) 
    end

    def insert( {char, freq}, [] ) do [{char,freq}] end

    def insert( {char1 , freq1 }, [ { char2, freq2} | rest ] ) when freq1 < freq2 do
        [{char1, freq1}, {char2, freq2} | rest]
    end

    def insert({char1, freq1}, [{char2, freq2} | rest]) do
        [{char2, freq2} | insert({char1, freq1}, rest)]
    end

#ENCODE TABLE

    def encode_table(tree) do
        encode_table(tree, [])
    end

    def encode_table({left, right}, path) do
        ll = encode_table(left, [0 | path])
        rl = encode_table(right, [1 | path])
        ll ++ rl        
    end

    def encode_table( a, path) do
        [ {a, path} ]
    end

    def encode_table_better(tree) do
        encode_table_better(tree, [], [])
    end

    def encode_table_better({left, right}, path, sofar) do
        encode_table_better(right, [1 | path], encode_table_better(left, [0 | path], sofar))
    end

    def encode_table_better(a, path, sofar) do
        [ {a, Enum.reverse(path)} | sofar]
    end

#DECODE TABLE

    def decode_table(tree) do
        encode_table_better(tree, [], [])
    end

    def decode_table(path, {left, right}) do
        ll = decode_table([0 | path], left)
        rl = decode_table([1 | path], right)
        ll ++ rl
    end

    def decode_table(path, a) do
        [{path, a}]
    end

#ENCODE
    
    def encode([], _) do [] end

    def encode([head | tail], encode_table) do
        find_encode(head, encode_table) ++ encode(tail, encode_table)
    end

    def find_encode(char, [{char, code} | _]) do code end

    def find_encode(char, [_ | rest]) do
        find_encode(char, rest)
    end

#DECODE    

    def decode([], _) do [] end

    def decode(seq, table) do
      {char, rest} = decode_char(seq, 1, table)
       [char | decode(rest, table)] 
    end


    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case List.keyfind(table, code, 1) do
            {a , _} -> {a, rest} 
            nil -> decode_char(seq, n + 1, table)
        end
    end

    def bench(file, n) do
        {text, b} = read(file, n)
        c = length(text)
        {tree, t2} = time(fn -> tree(text) end)
        {encode, t3} = time(fn -> encode_table(tree) end)
        s = length(encode)
        {decode, _} = time(fn -> decode_table(tree) end)
        {encoded, t5} = time(fn -> encode(text, encode) end)
        e = div(length(encoded), 8)
        r = Float.round(e / b, 3)
        {_, t6} = time(fn -> decode(encoded, decode) end)

    IO.puts("text of #{c} characters")
    IO.puts("tree built in #{t2} ms")
    IO.puts("table of size #{s} in #{t3} ms")
    IO.puts("encoded in #{t5} ms")
    IO.puts("decoded in #{t6} ms")
    IO.puts("source #{b} bytes, encoded #{e} bytes, compression #{r}")
    end

    def time(func) do
        initial = Time.utc_now()
        result = func.()
        final = Time.utc_now()
        {result, Time.diff(final, initial, :microsecond) / 1000}
    end


    def read(file, n) do
        {:ok, fd} = File.open(file, [:read])
        binary = IO.read(fd, n)
        File.close(fd)
        length = byte_size(binary)
        case :unicode.characters_to_list(binary, :utf8) do
        {:incomplete, chars, rest} -> {chars, length - byte_size(rest)}
        chars -> {chars, length}
        end
    end




end