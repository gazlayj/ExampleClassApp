//
//  ClassFetching.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

protocol ClassFetching {
    func fetchAllClasses() -> [SchoolClass]
    func fetchClass(withId id: UUID) -> SchoolClass?
}
