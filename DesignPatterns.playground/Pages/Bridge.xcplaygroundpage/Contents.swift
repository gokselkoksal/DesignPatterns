//: [Previous](@previous)

import Foundation

protocol DrawAPI {
    func draw()
}

class Shape {
    
    private let drawAPI: DrawAPI
    
    init(drawAPI: DrawAPI) {
        self.drawAPI = drawAPI
    }
    
    func draw() {
        drawAPI.draw()
    }
}

class CircleDrawAPI: DrawAPI {
    
    let color: String
    
    init(color: String) {
        self.color = color
    }
    
    func draw() {
        print("Drawing \(color) circle.")
    }
}

class RectangleDrawAPI: DrawAPI {
    
    let color: String
    
    init(color: String) {
        self.color = color
    }
    
    func draw() {
        print("Drawing \(color) rectangle.")
    }
}

let redCircle = Shape(drawAPI: CircleDrawAPI(color: "red"))
let blueRectangle = Shape(drawAPI: RectangleDrawAPI(color: "blue"))

redCircle.draw()
blueRectangle.draw()

//: [Next](@next)
