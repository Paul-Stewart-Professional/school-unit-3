import UIKit


// Given an array of numbers, check if any of the numbers are the ASCII values for lower case vowels (a, e, i, o, u).

// If they are, append the index of that value to an array in a dictionary where vowels are the keys.

// Return the resulting array.

// Hint: https://www.asciitable.com/
// https://stackoverflow.com/questions/24354549/how-to-get-string-from-ascii-code-in-swift


func yoinkVowels(in arr: [Int]) -> [String] {
    var newArr: [String] = []
    for num in arr {
        for int in 97...122 {
            if num == int {
                newArr.append(String(UnicodeScalar(UInt8(num))))
            }
        }
    }
    return newArr
}

let result = yoinkVowels(in: [2, 14, 98, 113, 122])
print(result)
