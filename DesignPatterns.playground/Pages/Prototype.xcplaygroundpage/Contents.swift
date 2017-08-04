//: [Previous](@previous)

import Foundation


class Settings {
    
    private let userDefaults = UserDefaults()
    
    private var _rememberedUsername: String? // Prototype
    var rememberedUsername: String? {
        get {
            if let _rememberedUsername = _rememberedUsername {
                return _rememberedUsername
            } else {
                _rememberedUsername = userDefaults.string(forKey: "rememberedUsername")
                return _rememberedUsername
            }
        }
        set {
            userDefaults.set(newValue, forKey: "rememberedUsername")
            _rememberedUsername = newValue
        }
    }
    
    private var _temperatureUnit: UnitTemperature?
    var temperatureUnit: UnitTemperature? {
        get {
            if let _temperatureUnit = _temperatureUnit {
                return _temperatureUnit
            } else {
                if let symbol = userDefaults.string(forKey: "temperatureUnit") {
                    _temperatureUnit = UnitTemperature(symbol: symbol)
                }
                return _temperatureUnit
            }
        }
        set {
            userDefaults.set(newValue?.symbol, forKey: "temperatureUnit")
            _temperatureUnit = newValue
        }
    }
}

let settings = Settings()
settings.rememberedUsername = "GK"
print(settings.rememberedUsername)
print(settings.rememberedUsername)

settings.temperatureUnit = UnitTemperature.celsius
print(settings.temperatureUnit)
print(settings.temperatureUnit)

//: [Next](@next)
