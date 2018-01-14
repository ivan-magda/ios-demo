//
//  ViewController.swift
//  GroupingTableViewDemo
//
//  Created by Brian Voong on 1/12/18.
//  Copyright © 2018 Lets Build That App. All rights reserved.
//

import UIKit

struct Person {
    let firstName: String
    let lastName: String
    let age: Int
}

final class ViewController: UITableViewController {
    
    private let people = [
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

    private let cellId = "cellId"
    
    private var isGroupingByAge = false
    private var groupedPeople = [[Person]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "NBA Stars"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Group Last Name",
            style: .plain,
            target: self,
            action: #selector(handleGroup)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Group Age",
            style: .plain,
            target: self,
            action: #selector(handleGroupAge)
        )
    }
    
    private func changeBarButtonsToReset() {
        navigationItem.leftBarButtonItem?.title = "Reset"
        navigationItem.rightBarButtonItem?.title = "Reset"
    }
    
    private func changeBarButtonsToOrig() {
        navigationItem.leftBarButtonItem?.title = "Group Age"
        navigationItem.rightBarButtonItem?.title = "Group Last Name"
    }
    
    @objc private func handleGroupAge() {
        if groupedPeople.count > 0 {
            groupedPeople.removeAll()
            tableView.reloadData()
            changeBarButtonsToOrig()
            return
        }
        
        isGroupingByAge = true
        let groupedDictionary = Dictionary(grouping: people) { (person) -> Int in
            return person.age
        }
        
        let keys = groupedDictionary.keys.sorted()
        
        keys.forEach({
            groupedPeople.append(groupedDictionary[$0]!)
        })
        tableView.reloadData()
        changeBarButtonsToReset()
    }
    
    @objc private func handleGroup() {
        if groupedPeople.count > 0 {
            groupedPeople.removeAll()
            tableView.reloadData()
            changeBarButtonsToOrig()
            return
        }
        
        isGroupingByAge = false
        let groupedDictionary = Dictionary(grouping: people) { (person) -> Character in
            return person.lastName.first!
        }
        
        let keys = groupedDictionary.keys.sorted()
        
        keys.forEach({
            groupedPeople.append(groupedDictionary[$0]!)
        })
        tableView.reloadData()
        changeBarButtonsToReset()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedPeople.count > 0 ? groupedPeople.count : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groupedPeople.count > 0 {
            return groupedPeople[section].count
        }

        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let person: Person
        
        if groupedPeople.count > 0 {
            person = groupedPeople[indexPath.section][indexPath.row]
        } else {
            person = people[indexPath.row]
        }
        
        cell.textLabel?.text = "\(person.firstName) \(person.lastName) - \(person.age)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if groupedPeople.count == 0 {
            return nil
        }
        
        let label = UILabel()
        if isGroupingByAge {
            if let age = groupedPeople[section].first?.age {
                label.text = "\(age)"
            }
        } else {
            if let lastNameChar = groupedPeople[section].first?.lastName.first {
                label.text = "\(lastNameChar)"
            }
        }
        label.backgroundColor = .lightGray
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return groupedPeople.count == 0 ? 0 : 30
    }
}
