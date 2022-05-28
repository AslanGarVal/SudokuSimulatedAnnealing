module Sudokus

using StatsBase: sample
export Sudoku, print, fill_square!

struct Sudoku
    numbers :: Array{Array{Int}}
end

Sudoku() = begin
    x = [sample(1:9, 9, replace = false) for _ in 1:9]
    Sudoku(x)
end

function Base.print(s:: Sudoku) 
    margin = repeat("+---", 9) * "+" 
    println(margin)
    for row in s.numbers
        r = reduce(*, ["| $x " for x in row]) * "|"
        println(r)
        println(margin)
    end
end

function fill_square!(s, (x, y), value)
    s.numbers[x][y] = value
end

end