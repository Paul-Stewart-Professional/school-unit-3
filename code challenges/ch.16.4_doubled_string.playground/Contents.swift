import UIKit

// Given a string, you have to return a string in which each character (case-sensitive) is repeated once.

// Examples (Input -> Output):
// * "String"      -> "SSttrriinngg"
// * "Hello World" -> "HHeelllloo  WWoorrlldd"
// * "1234!_ "     -> "11223344!!__  "
// Good Luck!

func repeatEach(string: String) -> String {
    var arrayForNewString: [Character] = []
    for character in string {
        arrayForNewString.append(contentsOf: (repeatElement(character, count: 2)))
    }
    let stringFromArray = String(arrayForNewString)
    return stringFromArray
}

let result = repeatEach(string: "HeLlo12 _")
print(result)
