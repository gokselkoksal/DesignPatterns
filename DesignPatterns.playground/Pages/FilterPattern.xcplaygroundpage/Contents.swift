//: [Previous](@previous)

import Foundation

enum Gender: String {
    case male
    case female
}

struct Person: CustomStringConvertible {
    
    let name: String
    let gender: Gender
    let age: UInt
    
    var description: String {
        return "{ \(name), \(gender.rawValue), \(age) }"
    }
}

protocol Filter {
    func predicate() -> NSPredicate
}

struct CompoundFilter: Filter {
    
    private enum Operation {
        case and
        case or
    }
    
    private let filters: [Filter]
    private let operation: Operation
    
    static func and(_ filters: Filter...) -> CompoundFilter {
        return CompoundFilter(filters: filters, operation: .and)
    }
    
    static func or(_ filters: Filter...) -> CompoundFilter {
        return CompoundFilter(filters: filters, operation: .or)
    }
    
    private init(filters: [Filter], operation: Operation) {
        self.filters = filters
        self.operation = operation
    }
    
    func predicate() -> NSPredicate {
        let predicates = filters.map { $0.predicate() }
        switch operation {
        case .and:
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        case .or:
            return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        }
    }
}

struct GenderFilter: Filter {
    
    let gender: Gender
    
    func predicate() -> NSPredicate {
        return NSPredicate { (person, _) -> Bool in
            guard let person = person as? Person else { return false }
            return person.gender == self.gender
        }
    }
}

struct MinimumAgeFilter: Filter {
    
    let age: UInt
    
    func predicate() -> NSPredicate {
        return NSPredicate { (person, _) -> Bool in
            guard let person = person as? Person else { return false }
            return person.age >= self.age
        }
    }
}

struct NamePrefixFilter: Filter {
    
    let prefix: String
    
    func predicate() -> NSPredicate {
        return NSPredicate { (person, _) -> Bool in
            guard let person = person as? Person else { return false }
            return person.name.hasPrefix(self.prefix)
        }
    }
}

let people = [
    Person(name: "Goksel", gender: .male, age: 26),
    Person(name: "Sila", gender: .female, age: 26),
    Person(name: "Gokalp", gender: .male, age: 20),
]

extension Array where Element == Person {
    func applying(_ filter: Filter) -> [Element] {
        return self.filter { filter.predicate().evaluate(with: $0) }
    }
}

let filter1 = CompoundFilter.and(MinimumAgeFilter(age: 18), NamePrefixFilter(prefix: "Go"))
let filter2 = GenderFilter(gender: .female)
let filter1OrFilter2 = CompoundFilter.or(filter1, filter2)
print(people.applying(filter1))
print(people.applying(filter2))
print(people.applying(filter1OrFilter2))

//: [Next](@next)
