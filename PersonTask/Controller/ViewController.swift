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

    private let childLabel: UILabel = {
        let label = UILabel()
        label.text = "Дети (макс. 5)"
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
        stackView.addSubview(personalLabel)
        stackView.addSubview(nameTextView)
        stackView.addSubview(ageTextView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // StackView constaints
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // PersonalLabel constraints
            personalLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 20),
            personalLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            personalLabel.heightAnchor.constraint(equalToConstant: 20),

            // NameTextView constraints
            nameTextView.topAnchor.constraint(equalTo: personalLabel.bottomAnchor, constant: 25),
            nameTextView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            nameTextView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15),
            nameTextView.heightAnchor.constraint(equalToConstant: 63),

            // AgeTextView constraints
            ageTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 13),
            ageTextView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            ageTextView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15),
            ageTextView.heightAnchor.constraint(equalToConstant: 63),
        ])
    }
}
