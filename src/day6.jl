using StaticArrays

function getnewages(ages)
    newages = Vector{UInt8}()
    for age in ages
        if age == 0
            push!(newages, 6, 8)
        else
            push!(newages, age - 1)
        end
    end
    return newages
end

function part1()
    input = open("input/day6.txt") do f
        return readline(f)
    end

    ages = parse.(UInt8, split(input, ','))
    for _ in 1:80
        ages = getnewages(ages)
    end
    return length(ages)
end

function part2()
    input = open("input/day6.txt") do f
        return readline(f)
    end

    ages = parse.(UInt8, split(input, ','))
    agebins = @MVector zeros(9)
    for age in ages
        agebins[age+1] += 1
    end
    for _ in 1:256
        newagebins = @MVector zeros(9)
        for i in 1:8
            newagebins[i] = agebins[i+1]
        end
        newagebins[7] += agebins[1]
        newagebins[9] += agebins[1]
        agebins = newagebins
    end
    return sum(agebins)
end
