//
//  Repository.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation
import UIKit

class Repository {
    static let shared = Repository()
    
    var classFetcher: ClassFetching { return classRepo }
    var classUpdater: ClassUpdating { return classRepo }
    
    var peopleFetcher: PeopleFetching { return peopleRepo }
    var peopleUpdater: PeopleUpdating { return peopleRepo }
    
    private let classRepo = ClassRepository()
    private let peopleRepo = PeopleRepository()
    
    private init() { }
}
