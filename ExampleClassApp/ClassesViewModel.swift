//
//  ClassesViewModel.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

class ClassesViewModel {
    let title = "All Classes"
    private(set) var classes: [SchoolClass]
    
    init(classes: [SchoolClass]) {
        self.classes = classes
    }
    
    func titleForClass(at index: Int) -> String {
        guard classes.count > index else { return "CLASS NOT FOUND" }
        return classes[index].name.capitalized
    }
    
    func subjectForClass(at index: Int) -> String? {
        guard classes.count > index else { return nil }
        return classes[index].subject.rawValue.capitalized
    }
}
