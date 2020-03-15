//
//  PeopleUpdating.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

protocol PeopleUpdating {
    func add(_ person: Person)
    func delete(_ person: Person)
    func update(_ person: Person)
}
