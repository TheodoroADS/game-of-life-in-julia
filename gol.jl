const width = 20
const height = 10

@enum Cell begin 
    Alive
    Dead
end


function render(b)

    for row in eachrow(b)
        for cell in row
            
            if cell == Alive 
                print("#")
            else
                print("-")
            end
        end

        println()
    end
end

function countNeighs(b::Matrix{Cell}, row,col)::UInt

    count = 0

    for drow  in -1:1
        for dcol in -1:1
            if drow != 0 || dcol != 0
                
                therow = row + drow
                thecol = col + dcol

                if therow < 1
                    therow = size(b,1)
                elseif therow > size(b,1)
                    therow = 1
                end

                if thecol < 1
                    thecol = size(b,2)
                elseif thecol > size(b,2)
                    thecol = 1
                end


                # if therow < 1 || therow > size(b,1) continue end
                # if thecol < 1 || thecol > size(b,2) continue end

                if b[therow,thecol] == Alive
                    count += 1
                end
            end
        end
    end

    return count
end

function update(b)

    for row in 1:size(b,1)
        for col in 1:size(b,2)

            cell = b[row,col]

            neighs = countNeighs(b, row,col)

            if cell == Alive 
                if neighs != 2 && neighs != 3
                    b[row,col] = Dead
                end
            else
                if neighs >= 3
                    b[row,col] = Alive
                end
            end
        end
    end
end

# board = fill(Dead, (height, width))

# board[2,3] = Alive
# board[3,4] = Alive
# for x in 2:4
#     board[4,x] = Alive
# end


board = Matrix{Cell}(undef, height,width)

for row in 1:size(board, 1)

    for col in 1:size(board,2)

        num = rand(1:10)

        if num == 1
            board[row,col] = Alive
        else 
            board[row,col] = Dead
        end

    end
end


for _ in range(1,10000)

    render(board)
    update(board)
    sleep(0.2)
    # println()
    print("\033[",height,"A")
    print("\033[",width,"D,")

end

