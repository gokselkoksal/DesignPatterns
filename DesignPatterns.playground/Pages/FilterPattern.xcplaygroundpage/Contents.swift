//: [Previous](@previous)

import Foundation

enum Gender {
    case male
    case female
}

struct Person {
    let name: String
    let gender: Gender
    let age: UInt
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

let filter1 = CompoundFilter.and(MinimumAgeFilter(age: 18), NamePrefixFilter(prefix: "Go"))
let filteredPeople1 = people.filter { filter1.predicate().evaluate(with: $0) }
print(filteredPeople1)

//: [Next](@next)
