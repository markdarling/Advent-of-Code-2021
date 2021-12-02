import UIKit

var input = """
199
200
208
210
200
207
240
269
260
263
"""


/* Common */
func convertToArray(input: String) -> [Int] {
    let stringArray = input.components(separatedBy: "\n")
    return stringArray.map { Int($0)! }
}


func countIncreases(input: [Int]) -> Int {
    var i = 0
    var lastNum = 0
    
    for thisNum in input {
        if lastNum > 0 && thisNum > lastNum {
            i=i+1
        }
        lastNum = thisNum
    }
    
    return i
}


func buildArrayOf3Sum(input: [Int]) -> [Int] {
    var sumArray: [Int] = []

    var s = Stack()
    for thisNum in input {
        s.addItem(newItem: thisNum)
        if s.isValid() {
            sumArray.append(s.sum())
        }
    }

    return sumArray
}

struct Stack {
    var items: [Int] = []
    
    mutating func addItem(newItem: Int) {
        items.append(newItem)
        if items.count > 3 {
            items.remove(at: 0)
        }
    }
    
    func show() {
        print (items)
    }
    
    func isValid() -> Bool {
        return items.count == 3
    }
    
    func sum() -> Int {
        return items.reduce(0, +)
    }
}



/* Solutions */

func solutionOne() {
    let intValues = convertToArray(input: input)
    let numberOfIncreases = countIncreases(input: intValues)
    print(numberOfIncreases)
}

func solutionTwo() {
    let intValues = convertToArray(input: input)
    let sumArray = buildArrayOf3Sum(input: intValues)
    let numberOfIncreases = countIncreases(input: sumArray)
    print(numberOfIncreases)
}


solutionOne()
solutionTwo()





