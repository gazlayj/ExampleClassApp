//
//  ClassUpdating.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

protocol ClassUpdating {
    func add(_ newClass: SchoolClass)
    func delete(_ deletedClass: SchoolClass)
    func update(_ updatedClass: SchoolClass)
}
