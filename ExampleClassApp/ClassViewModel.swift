//
//  ClassViewModel.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

class ClassViewModel {
    var title: String { return schoolClass.name.capitalized }
    
    var subject: String { return schoolClass.subject.rawValue.capitalized }
    
    var teacherName: String { return schoolClass.teacher.lastName + ", " + schoolClass.teacher.firstName }
    
    var students: [PersonViewModel] {
        return schoolClass.students.sorted { (lhs, rhs) in
            guard lhs.lastName != rhs.lastName else {
                return lhs.firstName < rhs.firstName
            }
        
            return lhs.lastName < rhs.lastName
        }
        .map { PersonViewModel(person: $0) }
    }
    
    private var schoolClass: SchoolClass
    private let classFetcher: ClassFetching
    
    init(schoolClass: SchoolClass, classFetcher: ClassFetching) {
        self.schoolClass = schoolClass
        self.classFetcher = classFetcher
    }
    
    func refresh() {
        guard let updatedClass = classFetcher.fetchClass(withId: schoolClass.id) else { return }
        schoolClass = updatedClass
    }
}

extension ClassViewModel {
    func makeEditClassViewModel() -> EditClassViewModel {
        return EditClassViewModel(schoolClass: schoolClass, classUpdater: Repository.shared.classUpdater)
    }
    

}
