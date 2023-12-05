import UIKit

// Complete the function that takes two integers (a, b, where a < b) and return an array of all integers between the input parameters, including them.

// For example:

// a = 1
// b = 4
// --> [1, 2, 3, 4]

// Black Diamond: Only return numbers that are divisible by a.

func rangeToArr(a: Int, b: Int) -> [Int]? {
    var arr: [Int] = []
    guard a < b else { return nil }
    for num in a...b {
        if num.isMultiple(of: a) {
            arr.append(num)
        }
    }
    return arr
}

let solution = rangeToArr(a: 2, b: 12)
print(solution)
