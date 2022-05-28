include("Sudokus.jl")
include("SimulatedAnnealingSolver.jl")

using Plots

newsudoku = Sudokus.Sudoku()
print(newsudoku)
#Sudokus.fill_square!(newsudoku, (1, 1), 0)
print(newsudoku)

println(SimulatedAnnealingSolver.energy(newsudoku))

es = SimulatedAnnealingSolver.simulated_annealing(newsudoku, 2_500, 10)

plot(es)

print(newsudoku)