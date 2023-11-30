import UIKit

// Create a function that can convert a binary number(represented in a string) to a decimal number.

// https://www.cuemath.com/numbers/binary-to-decimal/

func binaryToDecimal(binary: Int) -> Int {
    let decimal = Int(binary, radix: 2)
    return decimal
}

binaryToDecimal(binary: 1010)
