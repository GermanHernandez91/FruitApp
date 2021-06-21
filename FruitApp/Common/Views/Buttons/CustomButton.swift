import UIKit

final class CustomButton: UIButton {
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(bgColor: UIColor, title: String) {
        self.init(frame: .zero)
        backgroundColor = bgColor
        setTitle(title, for: .normal)
    }
}

// MARK: - Private implementation
private extension CustomButton {
    
    func configure() {
        layer.cornerRadius = 8
        backgroundColor = .purple
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
