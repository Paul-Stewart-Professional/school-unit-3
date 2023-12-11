import UIKit

// Write a simple function that takes a Date as a parameter and returns a Boolean representing whether the date is today or not.

// Make sure that your function does not return a false positive by only checking the day.



func isDateInToday(_ date: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDateInToday(date)
}

// Example usage:
let currentDate = Date()

if isDateInToday(currentDate) {
    print("The date is today.")
} else {
    print("The date is not today.")
}
