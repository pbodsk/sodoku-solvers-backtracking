import Cocoa

/*
var board = [
    [7, 8, 0, 4, 0, 0, 1, 2, 0],
    [6, 0, 0, 0, 7, 5, 0, 0, 9],
    [0, 0, 0, 6, 0, 1, 0, 7, 8],
    [0, 0, 7, 0, 4, 0, 2, 6, 0],
    [0, 0, 1, 0, 5, 0, 9, 3, 0],
    [9, 0, 4, 0, 6, 0, 0, 0, 5],
    [0, 7, 0, 3, 0, 0, 0, 1, 2],
    [1, 2, 0, 0, 0, 7, 4, 0, 0],
    [0, 4, 9, 2, 0, 6, 0, 0, 7]
]
*/

var board = [
    [0, 0, 8, 9, 1, 0, 0, 0, 5],
    [0, 0, 0, 0, 0, 0, 2, 0, 0],
    [0, 0, 5, 0, 0, 0, 4, 9, 0],
    [0, 0, 0, 5, 0, 0, 0, 1, 0],
    [0, 3, 0, 0, 0, 0, 0, 6, 0],
    [6, 0, 0, 7, 0, 8, 9, 0, 0],
    [0, 9, 0, 0, 0, 0, 6, 0, 3],
    [0, 0, 0, 0, 0, 6, 0, 0, 0],
    [0, 4, 0, 0, 8, 2, 0, 0, 0]
]

func printBoard(_ board: [[Int]]) {
    let topBottomRow = "+---------+---------+---------+"
    for (rowIndex, row) in board.enumerated() {
        if rowIndex % 3 == 0 {
            print(topBottomRow)
        }
        
        for (colIndex, col) in row.enumerated() {
            if colIndex % 3 == 0 {
                print("|", terminator:"")
            }
            if colIndex == 8 {
                print(" \(col) |")
            } else {
                print(" \(col) ", terminator:"")
            }
        }
    }
    print(topBottomRow)
}

func findEmpty(_ board: [[Int]]) -> (row: Int, col: Int)? {
    for(rowIndex, row) in board.enumerated() {
        for (colIndex, col) in row.enumerated() {
            if col == 0 {
                return (row: rowIndex, col: colIndex)
            }
        }
    }
    return nil
}

func solve(_ board: inout [[Int]]) -> Bool {
    guard let nextEmptySquare = findEmpty(board) else {
        return true
    }
    
    for number in (1...9) {
        if isValid(board: board, number: number, position: nextEmptySquare) {
            board[nextEmptySquare.row][nextEmptySquare.col] = number
            if solve(&board) {
                return true
            }
            board[nextEmptySquare.row][nextEmptySquare.col] = 0
        }
    }
    return false
}

func isValid(board: [[Int]], number: Int, position: (row: Int, col: Int)) -> Bool {
    // Check row
    let row = board[position.row]
    if row.contains(number) {
        return false
    }
    
    // Check column
    for column in 0..<board.count {
        if board[column][position.col] == number {
            return false
        }
    }
    
    // Check box
    let boxX: Int = position.col / 3
    let boxY: Int = position.row / 3
    
    for i in stride(from: boxY * 3, to: boxY * 3 + 3, by: 1) {
        for j in stride(from: boxX * 3, to: boxX * 3 + 3, by: 1) {
            if board[i][j] == number {
                return false
            }
        }
    }
    return true
}

printBoard(board)
print("solving...")
solve(&board)
print("solved!")
printBoard(board)
