import UIKit

final class ViewController: UIViewController {
    // MARK: - Properties
    var childrenData: [Child] = []

    // MARK: - UI Components
    private let nameTextView = CustomTextView(placeholder: "Имя")
    private let ageTextView = CustomTextView(placeholder: "Возраст")

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

    private lazy var addChildButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addTarget(self, action: #selector(addChildButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let childrenTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 165
        tableView.register(ChildTableViewCell.self, forCellReuseIdentifier: ChildTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var cleanButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        childrenTableView.delegate = self
        childrenTableView.dataSource = self

        hideKeyboardWhenTappedAround()
        if childrenData.isEmpty {
            let defaultChild = Child(name: "", age: "")
            childrenData.append(defaultChild)
        }
        setupViews()
        setupConstraints()
        DispatchQueue.main.async {
            self.childrenTableView.reloadData()
        }
    }
    // MARK: - Setup UI funcs
    private func setupViews() {
        view.addSubview(personalLabel)
        view.addSubview(nameTextView)
        view.addSubview(ageTextView)
        view.addSubview(childLabel)
        view.addSubview(childrenTableView)
        view.addSubview(addChildButton)
        view.addSubview(cleanButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // PersonalLabel constraints
            personalLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            personalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            personalLabel.heightAnchor.constraint(equalToConstant: 20),

            // NameTextView constraints
            nameTextView.topAnchor.constraint(equalTo: personalLabel.bottomAnchor, constant: 25),
            nameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nameTextView.heightAnchor.constraint(equalToConstant: 63),

            // AgeTextView constraints
            ageTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 13),
            ageTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ageTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            ageTextView.heightAnchor.constraint(equalToConstant: 63),

            // ChildLabel constraints
            childLabel.topAnchor.constraint(equalTo: ageTextView.bottomAnchor, constant: 33),
            childLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

            // AddChildButton constraints
            addChildButton.topAnchor.constraint(equalTo: ageTextView.bottomAnchor, constant: 20),
            addChildButton.leadingAnchor.constraint(equalTo: childLabel.trailingAnchor, constant: 18),
            addChildButton.heightAnchor.constraint(equalToConstant: 50),
            addChildButton.widthAnchor.constraint(equalToConstant: 200),

            // ChildrenTableView constraints
            childrenTableView.topAnchor.constraint(equalTo: addChildButton.bottomAnchor, constant: 20),
            childrenTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            childrenTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            childrenTableView.bottomAnchor.constraint(equalTo: cleanButton.topAnchor, constant: -20),

            // CleanButton constraints
            cleanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            cleanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            cleanButton.heightAnchor.constraint(equalToConstant: 50),
            cleanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65)
        ])
    }
    // MARK: - Action funcs
    @objc private func addChildButtonTapped() {
        let newChild = Child(name: "", age: "")
        childrenData.append(newChild)
        childrenTableView.insertRows(at: [IndexPath(row: childrenData.count - 1, section: 0)], with: .automatic)
        self.updateAddChildButtonHide()
    }

    @objc private func clearButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.nameTextView.text = ""
            self.ageTextView.text = ""
            self.childrenData = [Child(name: "", age: "")]
            self.childrenTableView.reloadData()
            self.addChildButton.isHidden = false
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    // MARK: - Private funcs
    private func updateAddChildButtonHide() { // Функция для скрытия кнопки, если кол-во детей достигло 5
        addChildButton.isHidden = childrenData.count >= 5
    }
}

// MARK: - ViewController tableView extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChildTableViewCell.identifier,
            for: indexPath
        ) as? ChildTableViewCell else {
            return UITableViewCell()
        }
        let child = childrenData[indexPath.row]
        cell.configure(with: child)

        cell.onUpdate = { [weak self] name, age in
            guard let self = self else { return }
            self.childrenData[indexPath.row] = Child(name: name, age: age)
        }
        cell.onDelete = { [weak self] in
            guard let self = self else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            guard indexPath.row < self.childrenData.count else { return }

            self.childrenData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateAddChildButtonHide()
        }
        cell.selectionStyle = .none
        return cell
    }
}
// MARK: - ViewController hide keyboard extension
extension ViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
