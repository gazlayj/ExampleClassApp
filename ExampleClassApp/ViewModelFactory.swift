//
//  ViewModelFactory.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/15/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

struct ViewModelFactory {
    static func makeClassesViewModel() -> ClassesViewModel {
        let classFetcher = Repository.shared.classFetcher
        return ClassesViewModel(classes: classFetcher.fetchAllClasses(), classFetcher: classFetcher)
    }
    
    static func makeClassViewModel(_ schoolClass: SchoolClass) -> ClassViewModel {
        return ClassViewModel(schoolClass: schoolClass, classFetcher: Repository.shared.classFetcher)
    }
    
    static func makeAddClassViewModel() -> EditClassViewModel {
        return makeEditClassViewModel(title: "Add Class", schoolClass: nil)
    }
    
    static func makeEditClassViewModel(_ schoolClass: SchoolClass? = nil) -> EditClassViewModel {
        return makeEditClassViewModel(title: "Edit Class", schoolClass: schoolClass)
    }
    
    static private func makeEditClassViewModel(title: String, schoolClass: SchoolClass?) -> EditClassViewModel {
        return EditClassViewModel(title: title, schoolClass: schoolClass, classUpdater: Repository.shared.classUpdater)
    }
    
    static func makePersonViewModel(_ person: Person) -> PersonViewModel {
        return PersonViewModel(person: person)
    }
}
