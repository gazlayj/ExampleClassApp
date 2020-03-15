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
    
    private let schoolClass: SchoolClass
    
    init(schoolClass: SchoolClass) {
        self.schoolClass = schoolClass
    }
}
