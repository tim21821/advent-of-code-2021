function part1()
    lines = open("input/day2.txt") do f
        return readlines(f)
    end

    position = [0, 0]
    for line in lines
        direction, amountstr = split(line, ' ')
        amount = parse(Int, amountstr)
        if direction == "forward"
            position[1] += amount
        elseif direction == "down"
            position[2] += amount
        elseif direction == "up"
            position[2] -= amount
        end
    end
    return position[1] * position[2]
end

function part2()
    lines = open("input/day2.txt") do f
        return readlines(f)
    end

    position = [0, 0]
    aim = 0
    for line in lines
        direction, amountstr = split(line, ' ')
        amount = parse(Int, amountstr)
        if direction == "forward"
            position[1] += amount
            position[2] += aim * amount
        elseif direction == "down"
            aim += amount
        elseif direction == "up"
            aim -= amount
        end
    end
    return position[1] * position[2]
end
