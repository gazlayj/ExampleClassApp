//
//  PeopleFetching.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

protocol PeopleFetching {
    func fetchAllPeople() -> [Person]
    func fetchPerson(withId id: UUID) -> Person?
}
