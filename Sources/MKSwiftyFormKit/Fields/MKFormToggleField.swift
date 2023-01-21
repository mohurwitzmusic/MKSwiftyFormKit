import UIKit

public struct MKFormToggleField: MKFormField, UIListContentConfigurable, Hashable, Identifiable {
    public let id: String
    public var displayState = MKFormFieldDisplayState()
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var isOn: Bool = false
    public init(id: String, isOn: Bool = false) {
        self.id = id
        self.isOn = isOn
    }
}



