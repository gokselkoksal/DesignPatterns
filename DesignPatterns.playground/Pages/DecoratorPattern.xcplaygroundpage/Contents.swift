//: [Previous](@previous)

import Foundation

protocol Shape {
    func draw()
}

protocol ShapeDecorator: Shape {
    var decoratedShape: Shape { get }
}

struct Circle: Shape {
    func draw() {
        print("Circle")
    }
}

struct BorderedCircle: ShapeDecorator {
    
    let decoratedShape: Shape
    let color: String
    
    init(decoratedShape: Shape, color: String) {
        self.decoratedShape = decoratedShape
        self.color = color
    }
    
    func draw() {
        decoratedShape.draw()
        print("Applying \(color) border.")
    }
}

let circle = Circle()
let redCircle = BorderedCircle(decoratedShape: circle, color: "red")
let blueCircle = BorderedCircle(decoratedShape: circle, color: "blue")

circle.draw()
redCircle.draw()
blueCircle.draw()

//: [Next](@next)
