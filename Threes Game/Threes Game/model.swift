//
//  model.swift
//  Created by Hassan Tariq on 3/20/20.
//  Copyright © 2020 Hassan Tariq. All rights reserved.
//

import Foundation
import UIKit

// Data structure to store info about each tile
struct Tile: Equatable {
    var val : Int
    var id : Int
    var row: Int
    var col: Int
}

class ButtonTile: UIButton {
    var tile = Tile(val: 0, id: 0, row: 0, col: 0)
    var should_remove = false
    var isNew = true
    
    convenience init(t: Tile) {
        self.init()
        tile = t
    }
}

class Triples {
    
    var board: [[Tile?]] = [[]]
    var score: Int = 0
    var id_num = 0
    
    func id_counter() -> Int{
        id_num += 1
        return id_num
    }
    
    // Initializing a new game in random mode or deterministic mode for testing
    func newgame(rand: Bool){
        score = 0
        id_num = 0
        board = Array( repeating: Array(repeating: nil, count:4), count:4)
        if rand == true {
            srand48(Int.random(in:1...1000))
        } else {
            srand48(42)
        }
    }
    
    
    func prng(max: Int) -> Int {
        let ret = Int(floor(drand48() * (Double(max))))
        return (ret < max) ? ret : (ret-1)
    }
    
    // Spawning the initial tiles randomly
    func spawn(){
        var emptyTileCount = 0
        for i in 0..<board.count {
            for j in 0..<board.count{
                if board[i][j] == nil {
                    emptyTileCount += 1
                }
            }
        }
        
        if emptyTileCount == 0 {
            return
        } else {
            let tileNumber = prng(max: 2)
            let tilePosition = prng(max: emptyTileCount)
            var indexToPlace = 0
            
            outerLoop: for i in 0..<board.count {
                for j in 0..<board.count{
                    if indexToPlace == tilePosition && board[i][j] == nil{
                        board[i][j] = Tile(val: tileNumber + 1, id: id_counter(), row: i, col: j)
                        score += tileNumber + 1
                        break outerLoop
                    } else if board[i][j] == nil {
                        indexToPlace += 1
                    }
                }
            }
        }
    }
    
    // Uses shift function which is implemented to collapse tiles to the left in combination with rotate function to manipulate the matrix appropriately for collapsing in any direction.
    func collapse(dir: Direction) -> Bool{
        let tempBoard = board
        switch dir {
        case .left:
            shift()
        case .right:
            rotate()
            rotate()
            shift()
            rotate()
            rotate()
        case .up:
            rotate()
            rotate()
            rotate()
            shift()
            rotate()
        case .down:
            rotate()
            shift()
            rotate()
            rotate()
            rotate()
        }
        
        for i in 0..<4 {
            for j in 0..<4 {
                if board[i][j] != nil {
                    board[i][j]!.row = i
                    board[i][j]!.col = j
                }
            }
        }
        
        
        if tempBoard == board {
            return false
        } else {
            return true
        }
    }
    
    //Checking to see when game is over
    func isDone() -> Bool{
        let tempScore = score
        let tempBoard = board
        if collapse(dir: .up) == false && collapse(dir: .down) == false &&
            collapse(dir: .left) == false && collapse(dir: .right) == false {
            board = tempBoard
            score = tempScore
            return true
        } else {
            score = tempScore
            board = tempBoard
            return false
        }
    }
    
    // rotate a square 2D Int array clockwise
    func rotate() {
        board = rotate2D(input: board)
    }
    
    // collapse tiles to the left
    func shift() {
        for i in 0..<board.count {
            for j in 0..<(board.count - 1){
                if (board[i][j]?.val == 1 && board[i][j+1]?.val == 2) || (board[i][j]?.val == 2 && board[i][j+1]?.val == 1) {
                    score += 3
                    board[i][j] = Tile(val: 3, id: id_counter(), row: i, col: j)
                    for k in (j+1)..<(board.count - 1){
                        if board[i][k+1] == nil {
                            board[i][k] = board[i][k+1]
                        } else {
                            board[i][k] = Tile(val: board[i][k+1]!.val, id: board[i][k+1]!.id, row: i, col: k)
                        }
                    }
                    board[i][board.count-1] = nil
                    break
                } else if board[i][j] == nil {
                    for k in j..<(board.count-1){
                        if board[i][k+1] == nil {
                            board[i][k] = board[i][k+1]
                        } else {
                            board[i][k] = Tile(val: board[i][k+1]!.val, id: board[i][k+1]!.id, row: i, col: k)
                        }
                    }
                    board[i][board.count-1] = nil
                    break
                } else if board[i][j] != nil && board[i][j+1] != nil && board[i][j]!.val >= 3 && board[i][j+1]!.val >= 3 && board[i][j]?.val == board[i][j+1]?.val {
                    score += board[i][j]!.val + board[i][j+1]!.val
                    board[i][j] = Tile(val: board[i][j]!.val + board[i][j+1]!.val, id: id_counter(), row: i, col: j)
                    for k in (j+1)..<(board.count-1){
                        if board[i][k+1] == nil {
                            board[i][k] = board[i][k+1]
                        } else {
                            board[i][k] = Tile(val: board[i][k+1]!.val, id: board[i][k+1]!.id, row: i, col: k)
                        }
                    }
                    board[i][board.count-1] = nil
                    break
                }
            }
        }
    }
}

enum Direction {
    case left, right, up, down
}

// class-less function that will return of any square 2D Int array rotated clockwise
public func rotate2DInts(input: [[Int]]) -> [[Int]] {
    var temp: [[Int]] = []
    temp = Array( repeating: Array(repeating: 0, count:input.count), count:input.count)
    for i in 0..<input.count {
        for j in 0..<input.count {
            temp [i][j] = input [input.count-j-1][i]
        }
    }
    return temp
}

// Generic function to rotate the 2D array of tiles clockwise to make it work on buttontiles
public func rotate2D<T>(input: [[T]]) -> [[T]] {
    var temp = input
    for i in 0..<input.count {
        for j in 0..<input.count {
            temp [i][j] = input [input.count-j-1][i]
        }
    }
    return temp
}

