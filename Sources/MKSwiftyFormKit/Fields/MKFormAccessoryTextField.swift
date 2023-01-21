import UIKit

public struct MKFormAccessoryTextField: MKFormField, Hashable, Identifiable, UIListContentConfigurable, MKFormTextFieldContentConfigurable {
    public let id: String
    public var displayState = MKFormFieldDisplayState()
    public var textField = MKFormTextFieldContentConfiguration()
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var textFieldWidth = TextFieldWidth.fractional(0.5)
    
    public enum TextFieldWidth: Hashable {
        case fixed(CGFloat)
        case fractional(CGFloat)
        static func `default`() -> Self {
            .fractional(0.5)
        }
    }
    
    public init(id: String, configuraton: UIListContentConfiguration = .cell()) {
        self.id = id
        self.contentConfiguration = configuraton
        textField.textAlignment = .right
    }
}


public extension MKFormAccessoryTextField {
    
    func textFieldWidth(_ width: TextFieldWidth) -> Self {
        var copy = self
        copy.textFieldWidth = width
        return copy
    }
    
}
