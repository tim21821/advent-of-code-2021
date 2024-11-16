using DataStructures
using Statistics

const OPENINGBRACKETS = Set(['(', '[', '{', '<'])

const CORRECTBRACKETS = Dict('(' => ')', '[' => ']', '{' => '}', '<' => '>')

const ERRORPOINTS = Dict(
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
    '(' => 1,
    '[' => 2,
    '{' => 3,
    '<' => 4,
)

function part1()
    lines = open("input/day10.txt") do f
        return readlines(f)
    end

    errorscore = 0
    for line in lines
        openings = Stack{Char}()
        for c in collect(line)
            if c in OPENINGBRACKETS
                push!(openings, c)
            else
                current = pop!(openings)
                if c != CORRECTBRACKETS[current]
                    errorscore += ERRORPOINTS[c]
                end
            end
        end
    end
    return errorscore
end

function part2()
    lines = open("input/day10.txt") do f
        return readlines(f)
    end

    errorscores = Vector{Int}()
    for line in lines
        openings = Stack{Char}()
        for c in collect(line)
            if c in OPENINGBRACKETS
                push!(openings, c)
            else
                current = pop!(openings)
                if c != CORRECTBRACKETS[current]
                    @goto nextline
                end
            end
        end
        errorscore = 0
        while !isempty(openings)
            current = pop!(openings)
            errorscore *= 5
            errorscore += ERRORPOINTS[current]
        end
        push!(errorscores, errorscore)
        @label nextline
    end
    return Int(median(errorscores))
end
