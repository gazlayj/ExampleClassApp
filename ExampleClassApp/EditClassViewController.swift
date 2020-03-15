//
//  EditClassViewController.swift
//  ExampleClassApp
//
//  Created by Justin Gazlay on 3/14/20.
//  Copyright © 2020 Justin Gazlay. All rights reserved.
//

import Foundation
import UIKit

protocol EditClassViewControllerDelegate: class {
    func editViewController(_ viewController: EditClassViewController, didSaveEdits: Bool)
}

class EditClassViewController: UIViewController {
    // MARK: - Views
    private lazy var editNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private lazy var editNameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private lazy var selectSubjectLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private lazy var selectedSubjectTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        return textField
    }()
    
    private lazy var subjectPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    // MARK: - Properties
    weak var delegate: EditClassViewControllerDelegate?
    
    // MARK: - Private Properties
    private let viewModel: EditClassViewModel
    private var viewModelObservers: [NSKeyValueObservation]?
    
    private let defaultHorizontalPadding: CGFloat = 10.0
    private let defaultVerticalPadding: CGFloat = 20.0
    
    // MARK: - Lifecycle
    init(_ viewModel: EditClassViewModel) {
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
        
        let nameStackView = UIStackView(arrangedSubviews: [editNameLabel, editNameTextField])
        nameStackView.axis = .horizontal
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.distribution = .fill
        nameStackView.alignment = .lastBaseline
        nameStackView.spacing = defaultHorizontalPadding
        editNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        view.addSubview(nameStackView)
        
        let selectSubjectTextStackView = UIStackView(arrangedSubviews: [selectSubjectLabel, selectedSubjectTextField])
        selectSubjectTextStackView.axis = .horizontal
        selectSubjectTextStackView.translatesAutoresizingMaskIntoConstraints = false
        selectSubjectTextStackView.distribution = .fill
        selectSubjectTextStackView.alignment = .lastBaseline
        selectSubjectTextStackView.spacing = defaultHorizontalPadding
        selectSubjectLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let subjectStackView = UIStackView(arrangedSubviews: [selectSubjectTextStackView, subjectPicker])
        subjectStackView.axis = .vertical
        subjectStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(subjectStackView)
        
        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: defaultHorizontalPadding),
            nameStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -defaultHorizontalPadding),
            nameStackView.heightAnchor.constraint(equalToConstant: defaultVerticalPadding * 2),
            nameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: defaultHorizontalPadding),
            subjectStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: defaultVerticalPadding),
            subjectStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -defaultHorizontalPadding),
            subjectStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            subjectStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: defaultHorizontalPadding)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissWithoutSaving))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = viewModel.title
        
        editNameLabel.text = viewModel.editNameTitle
        editNameTextField.placeholder = viewModel.namePlaceholder
        editNameTextField.text = viewModel.name
        
        selectSubjectLabel.text = viewModel.selectSubjectTitle
        selectedSubjectTextField.placeholder = viewModel.selectedSubjectPlaceholder
        selectedSubjectTextField.text = viewModel.selectedSubjectName
        
        viewModel.selectedSubjectIndex.flatMap { subjectPicker.selectRow($0, inComponent: 0, animated: false) }
        
        viewModelObservers = [
            viewModel.observe(\.selectedSubjectName) { [weak self] _, _ in
                self?.selectedSubjectTextField.text = self?.viewModel.selectedSubjectName
            }
        ]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModelObservers = nil
    }
    
    // MARK - Methods
    @objc func saveTapped() {
        viewModel.name = editNameTextField.text
        let saved = viewModel.save()
        // present error alert that save failed
        delegate?.editViewController(self, didSaveEdits: saved)
        dismiss(animated: true)
    }
    
    @objc func dismissWithoutSaving() {
        // present alert that edits will be lost
        dismiss(animated: true)
    }
}

extension EditClassViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.availableSubjectTitles.count
    }
}

extension EditClassViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.availableSubjectTitles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectedSubjectIndex = row
    }
}
