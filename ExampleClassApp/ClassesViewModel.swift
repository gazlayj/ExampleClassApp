//
//  ClassesViewModel.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

class ClassesViewModel: NSObject {
    let title = "All Classes"
    
    @objc dynamic private(set) var classesUpdated = false
    private(set) var classes: [SchoolClass] {
        didSet { classesUpdated = true }
    }
    
    private let allClasses: [SchoolClass]
    
    init(classes: [SchoolClass]) {
        self.allClasses = classes
        self.classes = classes
    }
    
    func apply(filter: String) {
        guard !filter.isEmpty else {
            classes = allClasses
            return
        }
        
        let lowercasedFilter = filter.lowercased()
        classes = allClasses.filter { $0.name.lowercased().contains(lowercasedFilter) || $0.subject.rawValue.lowercased().contains(lowercasedFilter) }
    }
    
    func titleForClass(at index: Int) -> String {
        guard classes.count > index else { return "CLASS NOT FOUND" }
        return classes[index].name.capitalized
    }
    
    func subjectForClass(at index: Int) -> String? {
        guard classes.count > index else { return nil }
        return classes[index].subject.rawValue.capitalized
    }
    
    func classViewModel(at index: Int) -> ClassViewModel {
        guard classes.count > index else { fatalError("index out of bounds") }
        return ClassViewModel(schoolClass: classes[index])
    }
}
