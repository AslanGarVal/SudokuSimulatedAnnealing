module SimulatedAnnealingSolver
include("Sudokus.jl")

export energy

function column_score(s)
    sum([length(unique(s.numbers[i])) for i = 1:9])
end
function row_score(s)
    sum([length(unique([s.numbers[i][j] for i = 1:9])) for j in 1:9])
end

function square_score(s)
    squares = [[s.numbers[k:k+2][j][l:l+2] for j in 1:3] 
        for k = [1, 3, 6], l = [1, 3, 6]]
    sum([length(unique(hcat(a...))) for a in squares])
end

energy(s) = -column_score(s) + -square_score(s)

temperature(T₀) = k -> T₀/k          

function swap!(s, p1, p2)
    x1, y1 = p1
    x2, y2 = p2

    temp = s.numbers[x1][y1]
    s.numbers[x1][y1] = s.numbers[x2][y2]
    s.numbers[x2][y2] = temp
end

function acceptance_prob(s1, s2, T)
    ΔE = energy(s2) - energy(s1)
    exp(-ΔE / T)
end

function simulated_annealing(s, max_iters, T₀)
    energies = [energy(s)]
    for k = 0:max_iters
        T = temperature(T₀)((k+1)/max_iters)
        x1, y1 = rand(1:9, 2)
        y2 = rand(1:9)

        s_temp = s
        swap!(s, (x1, y1), (x1, y2))

        s = acceptance_prob(s_temp, s, T) < rand() ? s : s_temp
        append!(energies, energy(s))
    end
    energies
end

end