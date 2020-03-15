//
//  ClassRepository.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

class ClassRepository {
    private var allClasses = Set(SchoolClass.defaultClasses)
    
    init() { }
}

extension ClassRepository: ClassFetching {
    func fetchAllClasses() -> [SchoolClass] {
        return allClasses.sorted { lhs, rhs in
            guard lhs.subject != rhs.subject else {
                return lhs.name < rhs.name
            }
            
            return lhs.subject.rawValue < rhs.subject.rawValue
        }
    }
    
    func fetchClass(withId id: UUID) -> SchoolClass? {
        return allClasses.first { $0.id == id }
    }
}

extension ClassRepository: ClassUpdating {
    func add(_ newClass: SchoolClass) {
        allClasses.insert(newClass)
    }
    
    func delete(_ deletedClass: SchoolClass) {
        allClasses.remove(deletedClass)
    }
    
    func update(_ updatedClass: SchoolClass) {
        guard let existingClass = allClasses.first(where: { $0.id == updatedClass.id }) else {
            add(updatedClass)
            return
        }
        
        delete(existingClass)
        add(updatedClass)
    }
}

