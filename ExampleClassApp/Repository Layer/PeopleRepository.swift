//
//  PeopleRepository.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

class PeopleRepository {
    private var allPeople = Set(Person.defaultStudents + [Person.defaultTeacher])
    
    init() { }
}

extension PeopleRepository: PeopleFetching {
    func fetchAllPeople() -> [Person] {
        return allPeople.sorted { lhs, rhs in
            guard lhs.lastName != rhs.lastName else {
                return lhs.firstName < rhs.firstName
            }
            
            return lhs.lastName < rhs.lastName
        }
    }
    
    func fetchPerson(withId id: UUID) -> Person? {
        return allPeople.first { $0.id == id }
    }
}

extension PeopleRepository: PeopleUpdating {
    func add(_ person: Person) {
        allPeople.insert(person)
    }
    
    func delete(_ person: Person) {
        allPeople.remove(person)
    }
    
    func update(_ person: Person) {
        guard let existingPerson = allPeople.first(where: { $0.id == person.id }) else {
            add(person)
            return
        }
        
        delete(existingPerson)
        add(person)
    }
}
