function part1()
    lines = open("input/day1.txt") do f
        return readlines(f)
    end

    increasecount = 0
    depth = parse.(Int, lines)
    for i in 2:length(depth)
        if depth[i] > depth[i-1]
            increasecount += 1
        end
    end
    return increasecount
end

function part2()
    lines = open("input/day1.txt") do f
        return readlines(f)
    end

    increasecount = 0
    depth = parse.(Int, lines)
    windows = [depth[i] + depth[i+1] + depth[i+2] for i in 1:length(depth)-2]
    for i in 2:length(windows)
        if windows[i] > windows[i-1]
            increasecount += 1
        end
    end
    return increasecount
end
