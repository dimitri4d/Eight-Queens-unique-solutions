# Dimitri Frederick
# nqueens.jl

function get_distinct()
    columns = (1:8)
    solutions = []

    # generate all the different permutations
    perms = collect(permutations(columns))
    for perm in perms
        plus  =Set()
        minus =Set()
        #check diagonal by by sum and difference of value and index
        for i in columns
            push!(plus,perm[i]+i)
            push!(minus,perm[i]-i)
        end
        #push to solutions if diagonally safe
        if 8 == length(plus) == length(minus)
            push!(solutions,perm)
        end
    end
    return solutions
end

# rotations
function rotate(p)
    n = length(p)
    rp = zeros(n)
    for i in (1:n)
        pos = findfirst(p,i)
        rp[i] = (n+1) - pos
    end
    return (rp)
end

# reflections
function reflect(p)
    n = length(p)
    rp = zeros(n)
    for i in (1:n)
        rp[p[i]] = i
    end
    return rp
end

function get_unique(solutions)
    _sol = solutions[:]
    unique = []

    while length(_sol) != 0
        pos = _sol[1]
        push!(unique,pos)
        #perform symmetry operations iterate through and remove duplicates
        for i in (  pos,
            rotate(pos),
            rotate(rotate(pos)),
            rotate(rotate(rotate(pos))),
            reflect(pos),
            rotate(reflect(pos)),
            rotate(rotate(reflect(pos))),
            rotate(rotate(rotate(reflect(pos)))))
            try
                deleteat!(_sol, findfirst(_sol, i))
            catch
                continue
            end
        end
    end
    return unique
end


#distinctSolutions[]
distinctSolutions = get_distinct()
uniqueSolutions = get_unique(distinctSolutions)
println("Number of unique solutions:",length(uniqueSolutions))
for sol in uniqueSolutions
    println(sol)
end
