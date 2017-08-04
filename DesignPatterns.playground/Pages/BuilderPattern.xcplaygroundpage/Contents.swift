//: [Previous](@previous)

import Foundation

// MARK: - Protocols

protocol MainFood: CustomStringConvertible {
    var name: String { get }
    var price: Float { get }
}

enum FoodSize: String {
    case normal
    case large
}

protocol Drink: MainFood {
    var size: FoodSize { get }
}

protocol SideFood: MainFood {
    var size: FoodSize { get }
}

// MARK: - Concrete types

struct BigMacBurger: MainFood {
    let name: String = "Big Mac Burger"
    let price: Float = 5.0
}

struct BigKingBurger: MainFood {
    let name: String = "Big King Burger"
    let price: Float = 6.0
}

struct Coke: Drink {
    let name: String = "Coke"
    var price: Float {
        switch size {
        case .large:  return 2.5
        case .normal: return 2.0
        }
    }
    let size: FoodSize
}

struct Milkshake: Drink {
    let name: String = "Milkshake"
    var price: Float {
        switch size {
        case .large:  return 4.0
        case .normal: return 3.5
        }
    }
    let size: FoodSize
}

struct Chips: SideFood {
    let name: String = "Chips"
    var price: Float {
        switch size {
        case .large:  return 4.0
        case .normal: return 3.5
        }
    }
    let size: FoodSize
}

struct Wings: SideFood {
    let name: String = "Wings"
    var price: Float {
        switch size {
        case .large:  return 4.5
        case .normal: return 4.0
        }
    }
    let size: FoodSize
}

struct Meal: CustomStringConvertible {
    
    let main: MainFood
    let side: SideFood
    let drink: Drink
    
    var description: String {
        return "\(main) | \(side) | \(drink) | Total: \(totalPrice())"
    }
    
    func totalPrice() -> Float {
        return main.price + side.price + drink.price
    }
}

// MARK: - Helpers

extension MainFood {
    var description: String {
        return name
    }
}

extension SideFood {
    var description: String {
        return "\(name) (\(size))"
    }
}

extension Drink {
    var description: String {
        return "\(name) (\(size))"
    }
}

// MARK: - Builder

class MealBuilder {
    
    enum DrinkType {
        case coke
        case milkshake
    }
    
    enum SideFoodType {
        case chips
        case wings
    }
    
    func makeBigMacMeal(withDrink drink: DrinkType, side: SideFoodType, size: FoodSize) -> Meal {
        return Meal(
            main: BigMacBurger(),
            side: makeSideFood(withType: side, size: size),
            drink: makeDrink(withType: drink, size: size)
        )
    }
    
    func makeBigKingMeal(withDrink drink: DrinkType, side: SideFoodType, size: FoodSize) -> Meal {
        return Meal(
            main: BigKingBurger(),
            side: makeSideFood(withType: side, size: size),
            drink: makeDrink(withType: drink, size: size)
        )
    }
    
    private func makeDrink(withType type: DrinkType, size: FoodSize) -> Drink {
        switch type {
        case .coke:      return Coke(size: size)
        case .milkshake: return Milkshake(size: size)
        }
    }
    
    private func makeSideFood(withType type: SideFoodType, size: FoodSize) -> SideFood {
        switch type {
        case .chips: return Chips(size: size)
        case .wings: return Wings(size: size)
        }
    }
}

// MARK: - Usage

let builder = MealBuilder()
let normalBigMacMeal = builder.makeBigMacMeal(withDrink: .coke, side: .chips, size: .normal)
let largeBigMacMeal = builder.makeBigMacMeal(withDrink: .coke, side: .chips, size: .large)
let normalBigKingMeal = builder.makeBigKingMeal(withDrink: .milkshake, side: .wings, size: .normal)
let largeBigKingMeal = builder.makeBigKingMeal(withDrink: .milkshake, side: .wings, size: .large)

print(normalBigMacMeal)
print(largeBigMacMeal)
print(normalBigKingMeal)
print(largeBigKingMeal)


//: [Next](@next)
