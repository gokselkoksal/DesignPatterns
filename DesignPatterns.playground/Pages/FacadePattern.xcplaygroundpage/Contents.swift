//: [Previous](@previous)

import Foundation

protocol GameObject {
    func render()
}

struct Ship: GameObject {
    func render() {
        print("Rendering ship.")
    }
}

struct Player: GameObject {
    func render() {
        print("Rendering player.")
    }
}

struct Projectile: GameObject {
    func render() {
        print("Rendering projectile.")
    }
}

class SettingsController {
    
    private var isSoundOn = true
    
    func toggleSound() {
        isSoundOn = !isSoundOn
        print("Sound: \(isSoundOn ? "On" : "Off")")
    }
    
    func saveGame() {
        print("Saving game...")
    }
}

class GameController {
    
    private(set) var gameObjects: [GameObject] = []
    private let settingsController = SettingsController()
    
    func addPlayer() {
        let object = Player()
        object.render()
        gameObjects.append(object)
    }
    
    func addShip() {
        let object = Ship()
        object.render()
        gameObjects.append(object)
    }
    
    func addProjectile() {
        let object = Projectile()
        object.render()
        gameObjects.append(object)
    }
    
    func save() {
        settingsController.saveGame()
    }
    
    func toggleSound() {
        settingsController.toggleSound()
    }
}

let game = GameController()
game.toggleSound()
game.addPlayer()
game.addShip()
game.addProjectile()
game.addProjectile()
game.save()

//: [Next](@next)
