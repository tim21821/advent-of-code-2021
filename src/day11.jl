function increaseadjacent!(energylevels::Matrix{UInt8}, pos::CartesianIndex)
    for y in -1:1
        for x in -1:1
            if x == 0 && y == 0
                continue
            end

            adjacent = pos + CartesianIndex(y, x)
            if checkbounds(Bool, energylevels, adjacent)
                energylevels[adjacent] += 1
            end
        end
    end
end

function part1()
    lines = open("input/day11.txt") do f
        return readlines(f)
    end

    energylevels = parse.(UInt8, stack(collect.(lines); dims = 1))
    flashcount = 0
    for _ in 1:100
        hasflashed = Set{CartesianIndex}()
        energylevels .+= 1
        stillflashing = true
        while stillflashing
            stillflashing = false
            for (y, col) in enumerate(eachcol(energylevels))
                for x in eachindex(col)
                    pos = CartesianIndex(y, x)
                    if energylevels[pos] > 9 && !(pos in hasflashed)
                        flashcount += 1
                        increaseadjacent!(energylevels, pos)
                        push!(hasflashed, pos)
                        stillflashing = true
                    end
                end
            end
        end
        energylevels[energylevels.>9] .= 0
    end
    return flashcount
end

function part2()
    lines = open("input/day11.txt") do f
        return readlines(f)
    end

    energylevels = parse.(UInt8, stack(collect.(lines); dims = 1))
    steps = 0
    while true
        steps += 1
        hasflashed = Set{CartesianIndex}()
        energylevels .+= 1
        stillflashing = true
        while stillflashing
            stillflashing = false
            for (y, col) in enumerate(eachcol(energylevels))
                for x in eachindex(col)
                    pos = CartesianIndex(y, x)
                    if energylevels[pos] > 9 && !(pos in hasflashed)
                        increaseadjacent!(energylevels, pos)
                        push!(hasflashed, pos)
                        stillflashing = true
                    end
                end
            end
        end
        if length(hasflashed) == length(energylevels)
            return steps
        end
        energylevels[energylevels.>9] .= 0
    end
end
