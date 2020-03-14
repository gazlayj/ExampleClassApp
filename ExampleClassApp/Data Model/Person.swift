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
