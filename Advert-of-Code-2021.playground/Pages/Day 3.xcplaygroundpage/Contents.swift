//: [Previous](@previous)

// Quick'n'Hacky

import Foundation

let input = """
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"""

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

func countBits(incomingArray: [String], position:Int) -> (Int, Int) {
    var numberOf0 = 0
    var numberOf1 = 0

    for number in incomingArray {
        let c = number[position]

        if (c == "0") {
            numberOf0 += 1
        } else {
            numberOf1 += 1
        }
    }
    
    return (numberOf0, numberOf1)
}

func filterOxygen(incomingArray: [String], position: Int) -> [String] {
    let bitCount = countBits(incomingArray: incomingArray, position: position)

    if bitCount.0 > bitCount.1 {
        return filterArray(incomingArray: incomingArray, position: position, positionValue: "0")
    } else {
        return filterArray(incomingArray: incomingArray, position: position, positionValue: "1")
    }
}

func filterCo2(incomingArray: [String], position: Int) -> [String] {
    let bitCount = countBits(incomingArray: incomingArray, position: position)
    
    if bitCount.1 >= bitCount.0 {
        return filterArray(incomingArray: incomingArray, position: position, positionValue: "0")
    } else {
        return filterArray(incomingArray: incomingArray, position: position, positionValue: "1")

    }
}
func filterArray(incomingArray: [String], position: Int, positionValue: String) -> [String] {
    var outArray: [String] = []
    for numberString in incomingArray {
        if String(numberString[position]) == positionValue {
            outArray.append(numberString)
        }
    }
    return outArray
}

func calculateCo2(inputArray: [String]) -> Int {
    var filteredArray = Array(inputArray)

    for i in 0..<inputArray.first!.count {
        filteredArray = filterCo2(incomingArray: filteredArray, position: i)
        if (filteredArray.count == 1) {
            return Int(filteredArray[0], radix: 2)!
        }
    }
    
    return 0
}

func calculateOxygen(inputArray: [String]) -> Int {
    var filteredArray = Array(inputArray)

    for i in 0..<inputArray.first!.count {
        filteredArray = filterOxygen(incomingArray: filteredArray, position: i)
        if (filteredArray.count == 1) {
            return Int(filteredArray[0], radix: 2)!
        }
    }
    
    return 0
}


func part1() {
    let inputArray = input.components(separatedBy: "\n")

    var gamma: [Int] = []
    var epsilon: [Int] = []

    for i in 0..<inputArray.first!.count {

        var numberOf0 = 0
        var numberOf1 = 0

        for number in inputArray {
            let c = number[i]

            
            if (c == "0") {
                numberOf0 += 1
            } else {
                numberOf1 += 1
            }
        }
        
        if numberOf1 > numberOf0 {
            gamma.append(1)
            epsilon.append(0)
        } else {
            gamma.append(0)
            epsilon.append(1)
        }
    }

    if let gammaDecimal = Int(gamma.map{ String($0) }.joined(), radix: 2), let epsilonDecimal = Int(epsilon.map{ String($0) }.joined(), radix: 2) {
        print("Answer 1: \(Int(gammaDecimal) * Int(epsilonDecimal))")
    }
}

func part2() {
    let inputArray = input.components(separatedBy: "\n")
    let co2Decimal = calculateCo2(inputArray: inputArray)
    let oxygenDecimal = calculateOxygen(inputArray: inputArray)
    print ("Answer 2: \(oxygenDecimal * co2Decimal)")
}


part1()
part2()
