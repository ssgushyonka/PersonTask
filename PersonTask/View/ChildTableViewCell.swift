import UIKit

final class ChildTableViewCell: UITableViewCell, UITextViewDelegate {
    // MARK: - Static Properties
    static let identifier = "ChildTableViewCell"

    // MARK: - Properties
    var onUpdate: ((String, String) -> Void)?

    // MARK: - UI Components
    private let nameTextView = CustomTextView(placeholder: "Имя")
    private let ageTextView = CustomTextView(placeholder: "Возраст")

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Override funcs
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI funcs
    private func setupUI() {
        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        ageTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameTextView)
        contentView.addSubview(ageTextView)
        contentView.addSubview(deleteButton)
        nameTextView.delegate = self
        ageTextView.delegate = self
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameTextView.heightAnchor.constraint(equalToConstant: 63),
            nameTextView.widthAnchor.constraint(equalToConstant: 200),

            ageTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 13),
            ageTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            ageTextView.heightAnchor.constraint(equalToConstant: 63),
            ageTextView.widthAnchor.constraint(equalToConstant: 200),

            deleteButton.centerYAnchor.constraint(equalTo: nameTextView.centerYAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: nameTextView.trailingAnchor, constant: 10)
        ])
    }

    // MARK: - Configure funcs
    func configure(with child: Child) {
        nameTextView.text = child.name
        ageTextView.text = child.age
    }

    func textViewDidChange(_ textView: UITextView) {
        onUpdate?(nameTextView.text ?? "", ageTextView.text ?? "")
    }

    // MARK: - Handler setup func
    private func setupHandlers() {
        nameTextView.onTextChanged = { [weak self] text in
            self?.onUpdate?(text, self?.ageTextView.text ?? "")
        }
        ageTextView.onTextChanged = { [weak self] text in
            self?.onUpdate?(self?.nameTextView.text ?? "", text)
        }
    }
}
