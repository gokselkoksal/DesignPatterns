//: [Previous](@previous)

import Foundation

// MARK: - Protocols

protocol ProductProtocol {
    var name: String { get }
    var price: Double { get }
}

protocol HasFoodSizeProtocol {
    var size: FoodSize { get }
}

protocol MainFoodProtocol: ProductProtocol, CustomStringConvertible { }
protocol DrinkProtocol: ProductProtocol, HasFoodSizeProtocol, CustomStringConvertible { }
protocol SideFoodProtocol: ProductProtocol, HasFoodSizeProtocol, CustomStringConvertible { }

// MARK: Types

enum FoodSize: String {
    case normal = "Normal"
    case large = "Large"
}

enum DrinkSelection: String {
    case coke = "Coke"
    case milkshake = "Milkshake"
}

enum SideFoodSelection: String {
    case chips = "Chips"
    case wings = "Wings"
}

enum BurgerSelection: String {
    case bigMac = "Big Mac"
    case bigKing = "Big King"
}

struct Drink: DrinkProtocol {
    
    let selection: DrinkSelection
    let size: FoodSize
    let price: Double
    
    var name: String {
        return selection.rawValue
    }
}

struct SideFood: SideFoodProtocol {
    
    let selection: SideFoodSelection
    let size: FoodSize
    let price: Double
    
    var name: String {
        return selection.rawValue
    }
}

struct Burger: MainFoodProtocol {
    
    let selection: BurgerSelection
    let price: Double
    
    var name: String {
        return selection.rawValue
    }
}

struct Meal {
    
    let main: MainFoodProtocol
    let side: SideFoodProtocol
    let drink: DrinkProtocol
    
    func totalPrice() -> Double {
        return main.price + side.price + drink.price
    }
}

// MARK: - Factories

class MealFactory {
    
    private static let burgerPrices: [BurgerSelection: Double] = [
        .bigKing: 6.5,
        .bigMac: 5.0
    ]
    
    private static let drinkPrices: [DrinkSelection: [FoodSize: Double]] = [
        .coke: [.normal: 2.0, .large: 2.5],
        .milkshake: [.normal: 3.5, .large: 4.0]
    ]
    
    private static let sideFoodPrices: [SideFoodSelection: [FoodSize: Double]] = [
        .chips: [.normal: 3.5, .large: 4.0],
        .wings: [.normal: 4.0, .large: 4.5]
    ]
    
    func makeBurger(selection: BurgerSelection) -> Burger {
        return Burger(
            selection: selection,
            price: MealFactory.burgerPrices[selection]!
        )
    }
    
    func makeDrink(selection: DrinkSelection, size: FoodSize) -> Drink {
        return Drink(
            selection: selection,
            size: size,
            price: MealFactory.drinkPrices[selection]![size]!
        )
    }
    
    func makeSideFood(selection: SideFoodSelection, size: FoodSize) -> SideFood {
        return SideFood(
            selection: selection,
            size: size,
            price: MealFactory.sideFoodPrices[selection]![size]!
        )
    }
}

// MARK: - Helpers

extension MainFoodProtocol {
    var description: String {
        return "\(name)"
    }
}

extension SideFoodProtocol {
    var description: String {
        return "\(name) (\(size))"
    }
}

extension DrinkProtocol {
    var description: String {
        return "\(name) (\(size))"
    }
}

extension Meal: CustomStringConvertible {
    var description: String {
        return "\(main) | \(side) | \(drink) | Total: \(totalPrice())"
    }
}

// MARK: - Builder

protocol ModelBuilder {
    associatedtype Model
    func build() -> Model
}

class BurgerMealBuilder: ModelBuilder {
    
    let burgerSelection: BurgerSelection
    var sideFoodSelection: SideFoodSelection = .chips
    var drinkSelection: DrinkSelection = .coke
    var mealSize: FoodSize = .normal
    
    private let factory = MealFactory()
    
    init(burgerSelection: BurgerSelection) {
        self.burgerSelection = burgerSelection
    }
    
    func build() -> Meal {
        return Meal(
            main: factory.makeBurger(selection: self.burgerSelection),
            side: factory.makeSideFood(selection: self.sideFoodSelection, size: self.mealSize),
            drink: factory.makeDrink(selection: self.drinkSelection, size: self.mealSize)
        )
    }
}

// MARK: - Usage

let bigKingBuilder = BurgerMealBuilder(burgerSelection: .bigKing)
bigKingBuilder.drinkSelection = .milkshake
bigKingBuilder.mealSize = .large

let bigMacBuilder = BurgerMealBuilder(burgerSelection: .bigMac)
bigMacBuilder.sideFoodSelection = .wings

let menu1 = bigKingBuilder.build()
let menu2 = bigMacBuilder.build()

print(menu1)
print(menu2)

//: [Next](@next)
