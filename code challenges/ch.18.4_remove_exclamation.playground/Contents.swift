import UIKit


// Description:
// Remove an exclamation mark from the end of a string. For a beginner kata, you can assume that the input data is always a string, no need to verify it.

// Examples
// remove("Hi!") === "Hi"
// remove("Hi!!!") === "Hi!!"
// remove("!Hi") === "!Hi"
// remove("!Hi!") === "!Hi"
// remove("Hi! Hi!") === "Hi! Hi"
// remove("Hi") === "Hi"


func removePoint(str: String) -> String {
    if str.suffix(1) == "!" {
        var newStr = str
        newStr.removeLast()
        return newStr
    } else {
        return str
    }
}

removePoint(str: "Hello!")

