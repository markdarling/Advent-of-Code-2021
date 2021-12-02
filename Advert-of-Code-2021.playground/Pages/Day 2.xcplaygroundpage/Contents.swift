import Foundation

let input = """
forward 5
down 5
forward 8
up 3
down 8
forward 2
"""

func part1() {
    let directions = input.components(separatedBy: "\n")

    var h = 0
    var d = 0

    for movement in directions {
        let arr = movement.components(separatedBy: " ")
        let direction = arr[0]
        let units = Int(arr[1])!
        
        switch direction {
            case "forward":
                h += units
            case "down":
                d += units
            case "up":
                d -= units
            default:
                print("")
        }
    }

    print ("Answer 1: \(h * d)")
}

func part2() {
    let directions = input.components(separatedBy: "\n")

    var h = 0
    var d = 0
    var a = 0

    for movement in directions {
        let arr = movement.components(separatedBy: " ")
        let direction = arr[0]
        let units = Int(arr[1])!
        
        switch direction {
            case "forward":
                h += units
                d += a*units
            case "down":
                a += units
            case "up":
                a -= units
            default:
                print("")
        }
    }

    print ("Answer 2: \(h * d)")

}

part1()
part2()
