import Foundation
import UIKit

protocol PlaceholderText {
    var placeholderText: String { get set }
}

final class CustomTextView: UITextView, PlaceholderText {
    // MARK: - Properties
    var onTextChanged: ((String) -> Void)?
    var placeholderText: String = "" {
        didSet {
            placeHolderLabel.text = placeholderText
        }
    }

    // MARK: - UI Components
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - init
    init(placeholder: String) {
        self.placeholderText = placeholder
        super.init(frame: .zero, textContainer: nil)

        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        self.layer.borderWidth = 2
        self.layer.borderColor = ColorsExtension.textViewBorder.cgColor
        self.textContainerInset = UIEdgeInsets(top: 30, left: 11, bottom: 8, right: 5)
        self.textColor = .black
        self.font = .systemFont(ofSize: 17)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self

        addSubview(placeHolderLabel)
        placeHolderLabel.text = placeholder

        // Setup placeholder constraints
        NSLayoutConstraint.activate([
            placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            placeHolderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupGesture() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange(_:)),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }

    @objc private func textDidChange(_ notification: Notification) {
        onTextChanged?(self.text)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension CustomTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        onTextChanged?(textView.text)
    }
}
