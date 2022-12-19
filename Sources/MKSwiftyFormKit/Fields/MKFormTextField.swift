import UIKit

public struct MKFormTextField: MKFormField, Hashable, MKFormTextFieldContentConfigurable, Identifiable {
    public let id: String
    public var textField: MKFormTextFieldContentConfiguration = .init()
    public var isDisabled = false
    public init(id: String) {
        self.id = id
    }
}


