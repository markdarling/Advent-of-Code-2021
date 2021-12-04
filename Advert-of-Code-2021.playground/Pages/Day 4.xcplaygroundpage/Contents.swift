//: [Previous](@previous)

import Foundation

let input = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"""

class BingoNumber {
    let value: Int
    var marked: Bool = false
    
    func setMarked(marked: Bool) {
        self.marked = marked
    }
    
    init(value: Int) {
        self.value = value
    }
    
}

class BingoLine {
    var values: [BingoNumber] = []
    
    init(lineString: String) {
        var numbersArray = lineString.components(separatedBy: " ")
        numbersArray.removeAll { n in
            n == ""
        }
        for n in numbersArray {
            values.append(BingoNumber(value: Int(n)! ))
        }
    }
    
    func isLine() -> Bool {
        for n in values {
            if !n.marked {
                return false
            }
        }
        
        return true
    }
    
    func markNumber(v: Int) {
        values.forEach({ n in
            if (!n.marked) {
                n.setMarked(marked: n.value == v)
            }
        })
    }
}

class BingoBoard {
    var lines: [BingoLine] = []
    var boardNumber: String
    
    init(boardNumber: String, boardString: String) {
        let linesArray = boardString.components(separatedBy: "\n")
        for l in linesArray {
            lines.append(BingoLine(lineString: l))
        }
        self.boardNumber = boardNumber
    }
    
    func isBingo() -> Bool {
        for l in lines {
            if !l.isLine() {
                return false
            }
        }
        
        return true
    }
    
    func hasLine() -> Bool {
        for l in lines {
            if l.isLine() {
                return true
            }
        }
        
        let lineLength = lines.first!.values.count
        var retVal = true
        for i in 0..<lineLength {
            retVal = true
            for l in lines {
                if !l.values[i].marked {
                    retVal = false
                }
            }
            if retVal {
                return true
            }
        }
        
        return false
    }
    
    func markNumber(v: Int) {
        for l in lines {
            l.markNumber(v: v)
        }
    }
    
    func calculateValue(calledNumber: Int) -> Int {
        var result = 0
        for l in lines {
            for n in l.values {
                if !n.marked {
                    result += n.value
                }
            }
        }
        return result * calledNumber

    }
}

func parseInput(input: String) -> ([Int], [BingoBoard]) {
    let calledNumbers = input.components(separatedBy: "\n").first!.components(separatedBy: ",").map{ Int($0)! }

    var boards: [BingoBoard] = []
    let boardsArray = input.components(separatedBy: "\n\n").dropFirst()
    
    for (i, b) in boardsArray.enumerated() {
        boards.append(BingoBoard(boardNumber: "Board \(i+1)", boardString: b))
    }
    
    return (calledNumbers, boards)
}

func solution() {
    let setup = parseInput(input: input)
    let numbersToCall = setup.0
    let boards = setup.1

    for n in numbersToCall {
        for b in boards.filter({ !$0.hasLine() }) {
            b.markNumber(v: n)
            
            if (b.hasLine()) {
                print("Called \(n) to make line (Board \(b.boardNumber)) - ANSWER: \(b.calculateValue(calledNumber: n))")
            }
        }
    }
    
}

solution()
