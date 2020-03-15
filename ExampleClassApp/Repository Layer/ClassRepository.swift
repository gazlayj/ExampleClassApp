//
//  ClassRepository.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

class ClassRepository {
    /*
     This is currently just loading some dummy static data but the next step would be to build out
     a persitant store of some sort for it to load from and write to. i.e. straight to disk, coredata, sql, etc.
     
     It would be resposnible for knowing when to update the persitant store. If updating is fast it might do it on every change, otherwise it might only do it on the app going to background.
     
     The data models that are stored to the persistant store might be somewhat different from the Models this consumes and returns. For instance it in this case it would probably make more sense for the store model of a class to only include the id's of the teacher and student instead of the entire people models which could end up being persisted many times over as a single person might be in many classes.
     
     In that case it would be better to just save the ids of all the people associated with the class and then when reading from the persistent store it could ask the PeopleRepository (who should be in charge of managing a persistent store of all the people) for the Person models it needs based on their ids.
     */
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

