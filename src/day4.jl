using StaticArrays

mutable struct Board
    numbers::MMatrix{5,5,UInt8}
    markings::MMatrix{5,5,Bool}
end

Board(numbers::MMatrix{5,5,UInt8}) = Board(numbers, @MMatrix fill(false, 5, 5))

Board(numbers::Matrix{UInt8}) = Board(MMatrix{5,5}(numbers))

function iswinning(board::Board)
    for col in eachcol(board.markings)
        if all(col)
            return true
        end
    end
    for row in eachrow(board.markings)
        if all(row)
            return true
        end
    end
    return false
end

function mark!(board::Board, number::UInt8)
    positions = findall(x -> x == number, board.numbers)
    for position in positions
        board.markings[position] = true
    end
end

function sumunmarked(board::Board)
    prod = 0
    for (num, mark) in zip(board.numbers, board.markings)
        if !mark
            prod += num
        end
    end
    return prod
end

function part1()
    lines = open("input/day4.txt") do f
        return readlines(f)
    end

    numbersdrawn = parse.(UInt8, split(lines[1], ','))
    boards = Vector{Board}()
    i = 2
    while i <= length(lines)
        numbers = MMatrix{5,5,UInt8}(undef)
        for j in 1:5
            row = parse.(UInt8, split(lines[i+j]))
            for k in 1:5
                numbers[j, k] = row[k]
            end
        end
        push!(boards, Board(numbers))
        i += 6
    end

    for n in numbersdrawn
        for board in boards
            mark!(board, n)
            if iswinning(board)
                return n * sumunmarked(board)
            end
        end
    end
end

function part2()
    lines = open("input/day4.txt") do f
        return readlines(f)
    end

    numbersdrawn = parse.(UInt8, split(lines[1], ','))
    boards = Vector{Board}()
    i = 2
    while i <= length(lines)
        numbers = MMatrix{5,5,UInt8}(undef)
        for j in 1:5
            row = parse.(UInt8, split(lines[i+j]))
            for k in 1:5
                numbers[j, k] = row[k]
            end
        end
        push!(boards, Board(numbers))
        i += 6
    end

    for n in numbersdrawn
        for board in boards
            mark!(board, n)
        end
        if length(boards) == 1 && iswinning(boards[1])
            return n * sumunmarked(boards[1])
        end
        filter!(!iswinning, boards)
    end
end
