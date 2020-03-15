//
//  ClassViewController.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation
import UIKit

class ClassViewController: UIViewController {
    // MARK: - Views
    private lazy var teacherView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var studentTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StudentTableViewCell.self, forCellReuseIdentifier: StudentTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.allowsSelection = false
        return tableView
    }()
    
    // MARK: - Private Properties
    private let viewModel: ClassViewModel
    
    // MARK: - Lifecycle
    init(_ viewModel: ClassViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(teacherView)
        view.addSubview(studentTableView)
        
        NSLayoutConstraint.activate([
            teacherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            teacherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            teacherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            studentTableView.topAnchor.constraint(equalTo: teacherView.bottomAnchor, constant: 10.0),
            studentTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            studentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            studentTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observeViewModel()
    }
    
    // MARK: - Methods
    @objc func editButtonTapped() {
        let editClassVC = EditClassViewController(viewModel.makeEditClassViewModel())
        editClassVC.delegate = self
        let navVC = UINavigationController(rootViewController: editClassVC)
        navigationController?.present(navVC, animated: true)
    }
    
    // MARK: - Private Methods
    func observeViewModel() {
        title = viewModel.title + " - " + viewModel.subject
        teacherView.text = viewModel.teacherName
        studentTableView.reloadData()
    }
}

extension ClassViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentTableViewCell.reuseId, for: indexPath)
        (cell as? StudentTableViewCell)?.update(with: viewModel.students[indexPath.row])
        return cell
    }
}

extension ClassViewController: EditClassViewControllerDelegate {
    func editViewController(_ viewController: EditClassViewController, didSaveEdits: Bool) {
        viewModel.refresh()
        observeViewModel()
    }
}
