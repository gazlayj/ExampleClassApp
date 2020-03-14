//
//  SchoolClass.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

struct SchoolClass {
    let name: String
    let subject: Subject
    let teacher: Person
    let students: Set<Person>
}

// MARK: - Dummy Data for development
extension SchoolClass {
    static let defaultClasses = [
        SchoolClass(name: "painting", subject: .art, teacher: .defaultTeacher, students: Set(Person.defaultStudents)),
        SchoolClass(name: "drawing", subject: .art, teacher: .defaultTeacher, students: Set(Person.defaultStudents)),
        SchoolClass(name: "world history", subject: .history, teacher: .defaultTeacher, students: Set(Person.defaultStudents)),
        SchoolClass(name: "Calculus", subject: .math, teacher: .defaultTeacher, students: Set(Person.defaultStudents)),
        SchoolClass(name: "Geometry", subject: .math, teacher: .defaultTeacher, students: Set(Person.defaultStudents))
    ]
}
