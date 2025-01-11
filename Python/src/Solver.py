board = [
    [0, 8, 0, 0, 0, 9, 4, 0, 0],
    [9, 0, 0, 0, 0, 7, 0, 1, 0],
    [0, 4, 6, 5, 0, 0, 8, 0, 0],
    [2, 0, 1, 0, 0, 5, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 3, 0, 0, 9, 0, 1],
    [0, 0, 7, 0, 0, 6, 5, 2, 0],
    [0, 6, 0, 7, 0, 0, 0, 0, 3],
    [0, 0, 4, 9, 0, 0, 0, 8, 0]
]

def print_board(board):
    for i in range(len(board)):
        if i % 3 == 0:
            print(" +-------+-------+-------+")

        for j in range(len(board[0])):
            char = str(board[i][j]) if board[i][j] != 0 else ' '
            if j % 3 == 0 and j != 0:
                print("| ", end="")
            if j == 8:
                print(char, end=" | \n")
            elif j == 0:
                print(" | " + char, end=" ")
            else:
                print(char + " ", end="")

    print(" +-------+-------+-------+")


def find_empty(board):
    for i in range(len(board)):
        for j in range(len(board[0])):
            if board[i][j] == 0:
                return i, j
    return None


def solve(board):
    next_square = find_empty(board)
    # No empty fields left, we must be done
    if not next_square:
        return True
    else:
        row, col = next_square

    for i in range(1, 10):
        if valid(board, i, (row, col)):
            board[row][col] = i
            if solve(board):
                return True
            # OK that didn't work, backtrack and try again
            board[row][col] = 0

    return False


def valid(board, number, position):
    # check row
    # gives us the length of a row
    for i in range(len(board[0])):
        if board[position[0]][i] == number and position[1] != i:
            return False

    # check col
    for i in range(len(board)):
        if board[i][position[1]] == number and position[0] != i:
            return False

    # check box
    box_x = position[1] // 3
    box_y = position[0] // 3

    for i in range(box_y * 3, box_y * 3 + 3):
        for j in range(box_x * 3, box_x * 3 + 3):
            if board[i][j] == number and (i, j) != position:
                return False

    return True

print_board(board)
solve(board)
print_board(board)