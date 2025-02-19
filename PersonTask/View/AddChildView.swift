import UIKit

class AddChildView: UIView {

    // MARK: - UI Components
    private let childLabel: UILabel = {
        let label = UILabel()
        label.text = "Дети (макс. 5)"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addChildButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Views
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(childLabel)
        stackView.addArrangedSubview(addChildButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.heightAnchor.constraint(equalTo: addChildButton.heightAnchor),
            stackView.widthAnchor.constraint(greaterThanOrEqualTo: childLabel.widthAnchor, constant: 10 + 200),

            // Ограничения для кнопки
            addChildButton.heightAnchor.constraint(equalToConstant: 50),
            addChildButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
