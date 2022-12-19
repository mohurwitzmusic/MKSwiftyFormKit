import UIKit

public protocol MKFormTextFieldContentConfigurable where Self : MKFormField {
    var textField: MKFormTextFieldContentConfiguration { get set }
}

public extension MKFormTextFieldContentConfigurable {
    
    func text(_ text: String) -> Self {
        var copy = self
        copy.textField.text = text
        return copy
    }
    
    func placeholder(_ placeholder: String) -> Self {
        var copy = self
        copy.textField.placeholder = placeholder
        return copy
    }
    
    func textFieldTextColor(_ color: UIColor) -> Self {
        var copy = self
        copy.textField.textColor = color
        return copy
    }
    
    func textFieldPlaceholderColor(_ color: UIColor) -> Self {
        var copy = self
        copy.textField.placeholderTextColor = color
        return copy
    }
    
    func textFieldFont(_ font: UIFont) -> Self {
        var copy = self
        copy.textField.font = font
        return copy
    }
    
    func textFieldTextAlignment(_ alignment: NSTextAlignment) -> Self {
        var copy = self
        copy.textField.textAlignment = alignment
        return copy
    }
    
    func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        var copy = self
        copy.textField.keyboardType = keyboardType
        return self
    }
}

extension UITextField {
    
    func configure(configuration: MKFormTextFieldContentConfiguration) {
        
    }
    
}
