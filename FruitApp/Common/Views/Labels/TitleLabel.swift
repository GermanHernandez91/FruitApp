import UIKit

final class TitleLabel: UILabel {
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        
        self.textAlignment  = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
}

// MARK: - Private implementation
private extension TitleLabel {
    
    func configure() {
        textColor = .label
        numberOfLines = 0
        minimumScaleFactor = 0.90
        lineBreakMode = .byWordWrapping
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
