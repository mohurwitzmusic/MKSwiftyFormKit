import UIKit

public struct MKFormTextFieldContentConfiguration: Hashable {
    public var text: String?
    public var textColor: UIColor = .label
    public var placeholder: String?
    public var placeholderTextColor: UIColor = .secondaryLabel
    public var font: UIFont = .preferredFont(forTextStyle: .body)
    public var keyboardType = UIKeyboardType.default
    public var textAlignment = NSTextAlignment.natural
    public init() { }
}

extension UITextField {
    
    func configure(_ configuration: MKFormTextFieldContentConfiguration) {
        text = configuration.text
        placeholder = configuration.placeholder
        textColor = configuration.textColor
        font = configuration.font
        keyboardType = configuration.keyboardType
        textAlignment = configuration.textAlignment
    }
    
}
