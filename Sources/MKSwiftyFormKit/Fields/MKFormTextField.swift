import UIKit

public struct MKFormTextField: MKFormField, UIListContentConfigurable {
    
    
    public struct TextFieldConfiguration: Equatable {
        public var text: String?
        public var textColor: UIColor = .label
        public var placeholder: String?
        public var placeholderTextColor: UIColor = .secondaryLabel
        public var font: UIFont = .preferredFont(forTextStyle: .body)
        public var keyboardType = UIKeyboardType.default
        public var autocorrectionType = UITextAutocorrectionType.default
        public var autocapitalizationType = UITextAutocapitalizationType.sentences
        public var textAlignment = NSTextAlignment.natural
        public var spellCheckingType = UITextSpellCheckingType.default
        public var borderStyle = UITextField.BorderStyle.none
        public init() { }
    }
    
    public let id: String
    public var textFieldConfiguration = TextFieldConfiguration()
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var displayState = MKFormFieldDisplayState()

    
    public init(id: String) {
        self.id = id
    }
}

public extension MKFormTextField {
    
    @discardableResult
    func text(_ text: String?) -> Self {
        var copy = self
        copy.textFieldConfiguration.text = text
        return copy
    }
    
    @discardableResult
    func placeholder(_ placeholder: String?) -> Self {
        var copy = self
        copy.textFieldConfiguration.placeholder = placeholder
        return copy
    }
    
    @discardableResult
    func textFieldTextColor(_ color: UIColor) -> Self {
        var copy = self
        copy.textFieldConfiguration.textColor = color
        return copy
    }
    
    @discardableResult
    func borderStyle(_ style: UITextField.BorderStyle) -> Self {
        var copy = self
        copy.textFieldConfiguration.borderStyle = style
        return copy
    }
    
    @discardableResult
    func autoCorrection(_ autocorrection: UITextAutocorrectionType) -> Self {
        var copy = self
        copy.textFieldConfiguration.autocorrectionType = autocorrection
        return copy
    }
    
    @discardableResult
    func autoCaptialization(_ autocapitalization: UITextAutocapitalizationType) -> Self {
        var copy = self
        copy.textFieldConfiguration.autocapitalizationType = autocapitalization
        return copy
    }
    
    @discardableResult
    func autoSpellChecking(_ spellChecking: UITextSpellCheckingType) -> Self {
        var copy = self
        copy.textFieldConfiguration.spellCheckingType = spellChecking
        return copy
    }
}


extension UITextField {
    
    func configure(_ configuration: MKFormTextField.TextFieldConfiguration) {
        text = configuration.text
        placeholder = configuration.placeholder
        textColor = configuration.textColor
        font = configuration.font
        keyboardType = configuration.keyboardType
        textAlignment = configuration.textAlignment
        autocorrectionType = self.autocorrectionType
        autocapitalizationType = self.autocapitalizationType
        spellCheckingType = self.spellCheckingType
        borderStyle = configuration.borderStyle
    }
    
}
