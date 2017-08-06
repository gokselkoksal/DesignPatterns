//: [Previous](@previous)

import Foundation

protocol Command {
    func execute()
}

enum Stock: String {
    case apple = "AAPL"
    case google = "GOOG"
    case yahoo = "YHOO"
    case tesla = "TSLA"
}

class BuyStockCommand: Command {
    
    let amount: Double
    let stock: Stock
    
    init(amount: Double, stock: Stock) {
        self.amount = amount
        self.stock = stock
    }
    
    func execute() {
        print("Bought \(amount) \(stock) stock.")
    }
}

class SellStockCommand: Command {
    
    let amount: Double
    let stock: Stock
    
    init(amount: Double, stock: Stock) {
        self.amount = amount
        self.stock = stock
    }
    
    func execute() {
        print("Sold \(amount) \(stock) stock.")
    }
}

class StockExchangeMarket {
    
    private(set) var orders: [Command] = []
    
    func addOrder(_ order: Command) {
        orders.append(order)
    }
    
    func processOrders() {
        orders.forEach { $0.execute() }
    }
}

let market = StockExchangeMarket()

market.addOrder(BuyStockCommand(amount: 30.0, stock: .apple))
market.addOrder(SellStockCommand(amount: 20.0, stock: .apple))
market.addOrder(BuyStockCommand(amount: 15.0, stock: .tesla))
market.addOrder(SellStockCommand(amount: 5.0, stock: .yahoo))
market.addOrder(BuyStockCommand(amount: 100.0, stock: .tesla))
market.addOrder(BuyStockCommand(amount: 20.0, stock: .tesla))

market.processOrders()

//: [Next](@next)
