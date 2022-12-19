import UIKit

public struct MKFormAccessoryTextField: MKFormField, Hashable, Identifiable, UIListContentConfigurable, MKFormTextFieldContentConfigurable {
    public let id: String
    public var isDisabled: Bool = false
    public var textField = MKFormTextFieldContentConfiguration()
    public var contentConfiguration = UIListContentConfiguration.cell()
    public init(id: String) {
        self.id = id
        textField.textAlignment = .right
    }
}

