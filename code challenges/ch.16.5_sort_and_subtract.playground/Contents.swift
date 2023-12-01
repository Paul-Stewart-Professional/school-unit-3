import UIKit

// Your task is to sum the differences between consecutive pairs in the array in descending order.

// Example
// [2, 1, 10]  -->  9
// In descending order: [10, 2, 1]

// Sum: (10 - 2) + (2 - 1) = 8 + 1 = 9

// If the array is empty or the array has only one element the result should be 0

func sortAndSubtract(array: [Int]) -> Int? {
    let sortedArray = array.sorted(by: >)
    var finalArray: [Int] = []
    guard sortedArray.count >= 2 else { return nil }
    for index in sortedArray {
        let firstNum = sortedArray[index]
        let secondNum = sortedArray[index + 1]
        let difference = firstNum - secondNum
        finalArray.append(difference)
    }
    return finalArray.reduce(0, +)
}

sortAndSubtract(array: [10, 2, 8, 5, 13])
