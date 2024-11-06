using DataStructures
using StaticArrays

isvertical(start::SVector{2,Int}, finish::SVector{2,Int}) = start[1] == finish[1]

ishorizontal(start::SVector{2,Int}, finish::SVector{2,Int}) = start[2] == finish[2]

function part1()
    lines = open("input/day5.txt") do f
        return readlines(f)
    end

    overlapcounts = DefaultDict{SVector{2,Int},Int}(0)
    for line in lines
        s, f = split(line, " -> ")
        start = SVector{2}(parse.(Int, split(s, ',')))
        finish = SVector{2}(parse.(Int, split(f, ',')))
        if isvertical(start, finish)
            for y in min(start[2], finish[2]):max(start[2], finish[2])
                position = @SVector [start[1], y]
                overlapcounts[position] += 1
            end
        elseif ishorizontal(start, finish)
            for x in min(start[1], finish[1]):max(start[1], finish[1])
                position = @SVector [x, start[2]]
                overlapcounts[position] += 1
            end
        end
    end
    return count(v -> v >= 2, values(overlapcounts))
end

function part2()
    lines = open("input/day5.txt") do f
        return readlines(f)
    end

    overlapcounts = DefaultDict{SVector{2,Int},Int}(0)
    for line in lines
        s, f = split(line, " -> ")
        start = SVector{2}(parse.(Int, split(s, ',')))
        finish = SVector{2}(parse.(Int, split(f, ',')))
        if isvertical(start, finish)
            for y in min(start[2], finish[2]):max(start[2], finish[2])
                position = @SVector [start[1], y]
                overlapcounts[position] += 1
            end
        elseif ishorizontal(start, finish)
            for x in min(start[1], finish[1]):max(start[1], finish[1])
                position = @SVector [x, start[2]]
                overlapcounts[position] += 1
            end
        else
            xdir = start[1] < finish[1] ? 1 : -1
            ydir = start[2] < finish[2] ? 1 : -1
            for step in 0:abs(start[1] - finish[1])
                position = @SVector [start[1] + xdir * step, start[2] + ydir * step]
                overlapcounts[position] += 1
            end
        end
    end
    return count(v -> v >= 2, values(overlapcounts))
end
