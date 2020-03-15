//
//  EditClassViewModel.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation

class EditClassViewModel: NSObject {
    let title = "Edit Class"
    
    let editNameTitle = "Name:"
    let namePlaceholder = "Enter class name"
    var name: String?
    
    lazy var availableSubjectTitles: [String] = {
        return availableSubjects.map { $0.rawValue.capitalized }
    }()
    
    private lazy var availableSubjects: [Subject] = Subject.allCases
    
    let selectSubjectTitle = "Subject:"
    let selectedSubjectPlaceholder = "Select a subject"
    @objc dynamic private(set) var selectedSubjectName: String?
    var selectedSubjectIndex: Int? {
        didSet { updateSelectedSubjectName() }
    }
    
    private let classUpdater: ClassUpdating
    private var schoolClass: SchoolClass?
    
    
    init(schoolClass: SchoolClass?, classUpdater: ClassUpdating) {
        self.schoolClass = schoolClass
        self.classUpdater = classUpdater
        self.name = schoolClass?.name.capitalized
        
        super.init()
        
        selectedSubjectIndex = schoolClass.flatMap { availableSubjects.firstIndex(of: $0.subject) }
        updateSelectedSubjectName()
    }
    
    func save() -> Bool {
        guard let name = name,
            !name.isEmpty,
            let subjectIndex = selectedSubjectIndex else {
                return false
        }
        
        let updatedClass = SchoolClass(id: schoolClass?.id ?? UUID(),
                                       name: name,
                                       subject: availableSubjects[subjectIndex],
                                       teacher: schoolClass?.teacher ?? Person.defaultTeacher,
                                       students: schoolClass?.students ?? Set(Person.defaultStudents))
        
        classUpdater.update(updatedClass)
        return true
    }
    
    private func updateSelectedSubjectName() {
        guard let index = selectedSubjectIndex else {
            selectedSubjectName = nil
            return
        }
        
        selectedSubjectName = availableSubjectTitles[index]
    }
}
