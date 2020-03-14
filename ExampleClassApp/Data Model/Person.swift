//
//  Person.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import UIKit
import Foundation

struct Person: Hashable {
    let id: UUID
    let firstName: String
    let lastName: String
    let favoriteColor: UIColor
}

// MARK: - Dummy Data for development
extension Person {
    static let defaultTeacher = Person(id: UUID(), firstName: "Default", lastName: "Teacher", favoriteColor: .blue)
    
    static let defaultStudents = [
        Person(id: UUID(), firstName: "Student-One", lastName: "Default", favoriteColor: .black),
        Person(id: UUID(), firstName: "Student-Two", lastName: "Default", favoriteColor: .yellow),
        Person(id: UUID(), firstName: "Student-Three", lastName: "Default", favoriteColor: .red),
        Person(id: UUID(), firstName: "Student-Four", lastName: "Default", favoriteColor: .green),
    ]
}
