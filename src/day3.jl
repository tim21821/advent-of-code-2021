function getgammarate(bitcounts::Vector{Dict{Char,Int}})
    gammarate = ""
    for count in bitcounts
        if count['0'] > count['1']
            gammarate *= '0'
        else
            gammarate *= '1'
        end
    end
    return parse(Int, gammarate, base = 2)
end

function getepsilonrate(bitcounts::Vector{Dict{Char,Int}})
    epsilonrate = ""
    for count in bitcounts
        if count['0'] < count['1']
            epsilonrate *= '0'
        else
            epsilonrate *= '1'
        end
    end
    return parse(Int, epsilonrate, base = 2)
end

function getoxygenrating!(lines::Vector{String})
    for i in 1:12
        bitcounts = Dict('0' => 0, '1' => 0)
        for line in lines
            bitcounts[line[i]] += 1
        end
        if bitcounts['0'] > bitcounts['1']
            filter!(line -> line[i] == '0', lines)
        else
            filter!(line -> line[i] == '1', lines)
        end
        if length(lines) == 1
            return parse(Int, lines[1], base = 2)
        end
    end
end

function getco2rating!(lines::Vector{String})
    for i in 1:12
        bitcounts = Dict('0' => 0, '1' => 0)
        for line in lines
            bitcounts[line[i]] += 1
        end
        if bitcounts['0'] <= bitcounts['1']
            filter!(line -> line[i] == '0', lines)
        else
            filter!(line -> line[i] == '1', lines)
        end
        if length(lines) == 1
            return parse(Int, lines[1], base = 2)
        end
    end
end

function part1()
    lines = open("input/day3.txt") do f
        return readlines(f)
    end

    bitcounts = [
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
        Dict('0' => 0, '1' => 0),
    ]
    for line in lines
        for (i, bit) in enumerate(line)
            bitcounts[i][bit] += 1
        end
    end
    return getgammarate(bitcounts) * getepsilonrate(bitcounts)
end

function part2()
    lines = open("input/day3.txt") do f
        return readlines(f)
    end

    return getoxygenrating!(deepcopy(lines)) * getco2rating!(deepcopy(lines))
end
