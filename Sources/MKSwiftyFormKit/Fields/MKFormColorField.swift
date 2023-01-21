import UIKit

public struct MKFormColorField: MKFormField, Hashable, Identifiable, UIListContentConfigurable {
    public let id: String
    public var displayState = MKFormFieldDisplayState()
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var color: UIColor
    public init(id: String,  color: UIColor) {
        self.id = id
        self.color = color
    }
}
