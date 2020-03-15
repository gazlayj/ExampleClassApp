//
//  SchoolClass.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

struct SchoolClass: Hashable {
    let id: UUID
    let name: String
    let subject: Subject
    let teacher: Person
    let students: Set<Person>
}

// MARK: - Dummy Data for development
extension SchoolClass {
    static let defaultClasses = [
        SchoolClass(id: UUID(), name: "painting", subject: .art, teacher: .defaultTeacher, students: Set(Person.defaultStudents)),
        SchoolClass(id: UUID(), name: "drawing", subject: .art, teacher: .defaultTeacher, students: Set(Person.defaultStudents)),
        SchoolClass(id: UUID(), name: "world history", subject: .history, teacher: .defaultTeacher, students: Set(Person.defaultStudents)),
        SchoolClass(id: UUID(), name: "Calculus", subject: .math, teacher: .defaultTeacher, students: Set(Person.defaultStudents)),
        SchoolClass(id: UUID(), name: "Geometry", subject: .math, teacher: .defaultTeacher, students: Set(Person.defaultStudents))
    ]
}
