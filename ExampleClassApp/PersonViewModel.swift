//
//  PersonViewModel.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation
import UIKit

class PersonViewModel {
    var firstName = ""
    var lastName = ""
    var backgroundColor = UIColor.clear
    
    private var id = UUID()
    
    init(person: Person?) {
        guard let person = person else { return }
        firstName = person.firstName
        lastName = person.lastName
        backgroundColor = person.favoriteColor
        id = person.id
    }
}

