import Foundation

struct Person {
    let firstName: String
    let lastName: String
    let age: Int
}

let people = [
    Person(firstName: "Michael", lastName: "Jordan", age: 55),
    Person(firstName: "Kobe", lastName: "Bryant", age: 42),
    Person(firstName: "Magic", lastName: "Johnson", age: 61),
    Person(firstName: "Steph", lastName: "Curry", age: 28),
    Person(firstName: "Lebron", lastName: "James", age: 34),
    Person(firstName: "Kevin", lastName: "Durant", age: 28),
    Person(firstName: "Klay", lastName: "Thompson", age: 28),
    Person(firstName: "Charles", lastName: "Barkley", age: 55),
    Person(firstName: "Kenny", lastName: "Johnson", age: 56),
    Person(firstName: "Clyde", lastName: "Drexler", age: 61),
    Person(firstName: "Vince", lastName: "Carter", age: 41),
    Person(firstName: "James", lastName: "Harden", age: 28),
    Person(firstName: "Anthony", lastName: "Davis", age: 28),
    Person(firstName: "Vlade", lastName: "Divac", age: 55)
]

let groupedDictByAge = Dictionary(grouping: people) { (people) -> Int in
    return people.age
}

var groupedArrByAge = [[Person]]()

groupedDictByAge.keys.sorted().forEach { (key) in
    groupedArrByAge.append(groupedDictByAge[key]!)
}

groupedArrByAge.forEach({
    $0.forEach({print($0)})
    print("---------")
})

let groupedDictByName = Dictionary(grouping: people) { (people) -> Character in
    return people.lastName.first!
}

var groupedArrByName = [[Person]]()

groupedDictByName.keys.sorted().forEach { (key) in
    groupedArrByName.append(groupedDictByName[key]!)
}

print("\n\n")
groupedArrByName.forEach({
    $0.forEach({print($0)})
    print("---------")
})
