import UIKit

// "Point reflection" or "point symmetry" is a basic concept in geometry where a given point, P, at a given position relative to a mid-point, Q has a corresponding point, P1, which is the same distance from Q but in the opposite direction.
// Task
// Given two points P and Q, output the symmetric point of point P about Q. Each argument is of the type Point. Output should be in the same format, giving the X and Y coordinates of point P1. You do not have to validate the input.
// Examples
// (0, 0) & (1, 1) => (2, 2)
// (2, 6) & (-2, -6) => (-6, -18)
struct Point {
    var x: Int
    var y: Int
}

let p = Point(x: 3, y: 4)
let q = Point(x: -1, y: -1)

func reflect(p: Point, q: Point) -> Point {
    let p1X = (2 * (q.x) - p.x)
    let p1Y = (2 * (q.y) - p.y)
    let newPoint = Point(x: p1X, y: p1Y)
    return newPoint
}

let results = reflect(p: p, q: q)
print(results)
