using Bijections

function isuniquenumber(pattern::AbstractString)
    len = length(pattern)
    return len == 2 || len == 4 || len == 3 || len == 7
end

function getpossibilities(pattern::Set{Char})
    len = length(pattern)
    if len == 2
        return [1]
    elseif len == 3
        return [7]
    elseif len == 4
        return [4]
    elseif len == 5
        return [2, 3, 5]
    elseif len == 6
        return [0, 6, 9]
    else
        return [8]
    end
end

function getunknown(pattern::Set{Char}, knownnumbers::Bijection{Set{Char},Int})
    if length(pattern) == 5
        sevenpattern = knownnumbers(7)
        if issubset(sevenpattern, pattern)
            return 3
        else
            fourpattern = knownnumbers(4)
            if length(intersect(fourpattern, pattern)) == 3
                return 5
            else
                return 2
            end
        end
    else
        fourpattern = knownnumbers(4)
        if issubset(fourpattern, pattern)
            return 9
        else
            sevenpattern = knownnumbers(7)
            if issubset(sevenpattern, pattern)
                return 0
            else
                return 6
            end
        end
    end
end

function part1()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    output = [split(line, " | ")[2] for line in lines]
    uniquecount = 0
    for o in output
        patterns = split(o)
        uniquecount += count(isuniquenumber, patterns)
    end
    return uniquecount
end

function part2()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    outputsum = 0
    for line in lines
        patterns = split(split(line, " | ")[1])
        outputs = split(split(line, " | ")[2])
        knownnumbers = Bijection{Set{Char},Int}()

        for p in patterns
            pattern = Set(p)
            possibilities = getpossibilities(pattern)
            if length(possibilities) == 1
                knownnumbers[pattern] = possibilities[1]
            end
        end
        for p in patterns
            pattern = Set(p)
            if pattern in keys(knownnumbers)
                continue
            end
            knownnumbers[pattern] = getunknown(pattern, knownnumbers)
        end

        outnumber = 0
        for (i, output) in enumerate(reverse(outputs))
            pattern = Set(output)
            outnumber += 10^(i - 1) * knownnumbers[pattern]
        end
        outputsum += outnumber
    end

    return outputsum
end
