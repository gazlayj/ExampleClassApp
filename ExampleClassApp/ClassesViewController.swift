//
//  ViewController.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import UIKit

class ClassesViewController: UIViewController {
    
    // MARK: - Views
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ClassTableViewCell.self, forCellReuseIdentifier: ClassTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Private Properties
    private let viewModel: ClassesViewModel
    private var viewModelObservers: [NSKeyValueObservation]?
    
    // MARK: - Lifecycle
    init(viewModel: ClassesViewModel) {
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
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelObservers = [
            viewModel.observe(\.classesUpdated) { [weak self] _, _ in self?.tableView.reloadData() }
        ]
        
        title = viewModel.title
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModelObservers = nil
    }
    
    // MARK: - Private Methods
    @objc func addTapped() {
        let addClassVC = EditClassViewController(viewModel.makeAddClassViewModel())
        addClassVC.delegate = self
        let navVC = UINavigationController(rootViewController: addClassVC)
        navigationController?.present(navVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ClassesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassTableViewCell.reuseId, for: indexPath)
        cell.textLabel?.text = viewModel.titleForClass(at: indexPath.row)
        cell.detailTextLabel?.text = viewModel.subjectForClass(at: indexPath.row)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ClassesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: false) }
        let classVC = ClassViewController(viewModel.classViewModel(at: indexPath.row))
        navigationController?.pushViewController(classVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension ClassesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.apply(filter: searchText)
    }
}

// MARK: - EditClassViewControllerDelegate
extension ClassesViewController: EditClassViewControllerDelegate {
    func editViewController(_ viewController: EditClassViewController, didSaveEdits: Bool) {
        searchBar.text = nil
        viewModel.refreshClasses()
    }
}

