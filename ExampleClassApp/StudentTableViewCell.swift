//
//  StudentTableViewCell.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation
import UIKit

class StudentTableViewCell: UITableViewCell {
    // MARK: Static Properties
    static let reuseId = String(describing: StudentTableViewCell.self)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier ?? StudentTableViewCell.reuseId)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        update(with: nil)
        super.prepareForReuse()
        
    }
    
    // MARK: - API Methods
    func update(with viewModel: PersonViewModel?) {
        textLabel?.text = viewModel?.firstName
        detailTextLabel?.text = viewModel?.lastName
        backgroundColor = (viewModel?.backgroundColor ?? .clear).withAlphaComponent(0.2)
    }
}
