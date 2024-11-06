function part1()
    input = open("input/day7.txt") do f
        return readline(f)
    end

    positions = parse.(Int, split(input, ','))
    cheapestfuel = typemax(Int)
    for goal in minimum(positions):maximum(positions)
        fuel = 0
        for position in positions
            fuel += abs(goal - position)
        end
        cheapestfuel = min(cheapestfuel, fuel)
    end
    return cheapestfuel
end

function part2()
    input = open("input/day7.txt") do f
        return readline(f)
    end

    positions = parse.(Int, split(input, ','))
    cheapestfuel = typemax(Int)
    for goal in minimum(positions):maximum(positions)
        fuel = 0
        for position in positions
            dist = abs(goal - position)
            fuel += (dist * (dist + 1)) ÷ 2
        end
        cheapestfuel = min(cheapestfuel, fuel)
    end
    return cheapestfuel
end
