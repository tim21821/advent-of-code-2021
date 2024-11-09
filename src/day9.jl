function islowpoint(grid::Matrix{UInt8}, row::Int, col::Int)
    if checkbounds(Bool, grid, row - 1, col) && grid[row-1, col] <= grid[row, col]
        return false
    elseif checkbounds(Bool, grid, row + 1, col) && grid[row+1, col] <= grid[row, col]
        return false
    elseif checkbounds(Bool, grid, row, col - 1) && grid[row, col-1] <= grid[row, col]
        return false
    elseif checkbounds(Bool, grid, row, col + 1) && grid[row, col+1] <= grid[row, col]
        return false
    end
    return true
end

function getbasinsize!(grid::Matrix{UInt8}, point::CartesianIndex)
    size = 0
    if !checkbounds(Bool, grid, point)
        return size
    end
    if grid[point] != 10 && grid[point] < 9
        size += 1
        grid[point] = 10
        size += getbasinsize!(grid, point + CartesianIndex(1, 0))
        size += getbasinsize!(grid, point + CartesianIndex(-1, 0))
        size += getbasinsize!(grid, point + CartesianIndex(0, 1))
        size += getbasinsize!(grid, point + CartesianIndex(0, -1))
    end
    return size
end

function part1()
    lines = open("input/day9.txt") do f
        return readlines(f)
    end

    grid = parse.(UInt8, stack(collect.(lines); dims = 1))
    risksum = 0
    for (i, col) in enumerate(eachcol(grid))
        for (j, height) in enumerate(col)
            if islowpoint(grid, j, i)
                risksum += 1 + height
            end
        end
    end
    return risksum
end

function part2()
    lines = open("input/day9.txt") do f
        return readlines(f)
    end

    grid = parse.(UInt8, stack(collect.(lines); dims = 1))
    lowpoints = Vector{CartesianIndex}()
    for (i, col) in enumerate(eachcol(grid))
        for j in eachindex(col)
            if islowpoint(grid, j, i)
                push!(lowpoints, CartesianIndex(j, i))
            end
        end
    end

    basinsizes = [getbasinsize!(grid, lowpoint) for lowpoint in lowpoints]
    sort!(basinsizes, rev = true)
    return basinsizes[1] * basinsizes[2] * basinsizes[3]
end
