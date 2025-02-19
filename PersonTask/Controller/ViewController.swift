//
//  ViewController.swift
//  PersonTask
//
//  Created by Элина Борисова on 19.02.2025.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Components
    private let nameTextView = CustomTextView(placeholder: "Имя")
    private let ageTextView = CustomTextView(placeholder: "Возраст")
    private let addChildView = AddChildView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 500)
    }

    private let personalLabel: UILabel = {
        let label = UILabel()
        label.text = "Персональные данные"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup UI funcs
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(personalLabel)
        stackView.addArrangedSubview(nameTextView)
        stackView.addArrangedSubview(ageTextView)
        stackView.addArrangedSubview(addChildView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // StackView constaints
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // PersonalLabel constraints
            personalLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            personalLabel.heightAnchor.constraint(equalToConstant: 20),

            // NameTextView constraints
            nameTextView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            nameTextView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15),
            nameTextView.heightAnchor.constraint(equalToConstant: 63),

            // AgeTextView constraints
            ageTextView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            ageTextView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15),
            ageTextView.heightAnchor.constraint(equalToConstant: 63),

            addChildView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            addChildView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15)
        ])
    }
}
