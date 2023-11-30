import UIKit

// Write a function that returns a string in which firstname is swapped with last name.

// Example(Input --> Output)

// "john McClane" --> "McClane john"

func lastFirst(name: String) {
    var swappedName: [String] = name.components(separatedBy: .whitespaces)
    swappedName.swapAt(0, 1)
    return swappedName
}

lastFirst(name: "Paul Stewart")
