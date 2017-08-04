//: [Previous](@previous)

import Foundation

protocol Graphic {
    func draw()
}

struct Spaceship: Graphic {
    func draw() {
        print("Spaceship")
    }
}

struct Rocket: Graphic {
    func draw() {
        print("Rocket")
    }
}

struct Planet: Graphic {
    func draw() {
        print("Planet")
    }
}

struct CompositeGraphic: Graphic {
    
    private(set) var content: [Graphic] = []
    
    init(content: [Graphic]) {
        self.content = content
    }
    
    mutating func add(_ graphic: Graphic) {
        content.append(graphic)
    }
    
    func draw() {
        content.forEach { $0.draw() }
    }
}

let spaceship = Spaceship()
let rocket = Rocket()
let planet1 = Planet()
let planet2 = Planet()

let scene1 = CompositeGraphic(content: [planet1, spaceship, rocket])
let scene2 = CompositeGraphic(content: [planet1, spaceship, planet2])
let scene3 = CompositeGraphic(content: [planet1, spaceship, planet2, rocket])

spaceship.draw()
print("--")
scene1.draw()
print("--")
scene2.draw()
print("--")
scene3.draw()

//: [Next](@next)
