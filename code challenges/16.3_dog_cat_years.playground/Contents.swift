import UIKit

// I have a cat and a dog.

// I got them at the same time as a kitten/puppy. That was humanYears years ago.

// Return their respective ages now as [humanYears,catYears,dogYears]

// NOTES:

// humanYears >= 1
// humanYears are whole numbers only

// Cat Years
// 15 cat years for first year
// +9 cat years for second year
// +4 cat years for each year after that

// Dog Years
// 15 dog years for first year
// +9 dog years for second year
// +5 dog years for each year after that

func animalYears(humanYears: Int) -> [Int] {
    var yearsArray: [Int] = []
    var catYears = 0
    var dogYears = 0
    yearsArray.append(humanYears)
    //human years done
    if humanYears == 1 {
        catYears = 15
        dogYears = 15
    } else if humanYears == 2 {
        catYears = 24
        dogYears = 24
    } else {
        catYears = (((humanYears - 2) * 4) + 24)
        dogYears = (((humanYears - 2) * 5) + 24)
    }
    yearsArray.append(catYears)
    yearsArray.append(dogYears)
    return yearsArray
}

let results = animalYears(humanYears: 2)
print(results)

