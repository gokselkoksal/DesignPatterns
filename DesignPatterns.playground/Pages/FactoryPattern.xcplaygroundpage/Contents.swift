//: [Previous](@previous)

import UIKit

protocol Shape {
    func draw()
}

struct Rectangle: Shape {
    func draw() {
        print("Rectangle")
    }
}

struct Circle: Shape {
    func draw() {
        print("Circle")
    }
}

struct Triangle: Shape {
    func draw() {
        print("Triangle")
    }
}

class ShapeFactory {
    
    enum ShapeType {
        case rectangle
        case circle
        case triangle
    }
    
    func make(_ type: ShapeType) -> Shape {
        switch type {
        case .circle:    return Circle()
        case .rectangle: return Rectangle()
        case .triangle:  return Triangle()
        }
    }
}

let factory = ShapeFactory()
let circle = factory.make(.circle)
let rectangle = factory.make(.rectangle)
let triangle = factory.make(.triangle)

circle.draw()
rectangle.draw()
triangle.draw()


//: [Next](@next)
