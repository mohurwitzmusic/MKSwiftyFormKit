import UIKit

public struct MKFormListField: MKFormField, UIListContentConfigurable, Hashable, Identifiable {
    public let id: String
    public var displayState = MKFormFieldDisplayState()
    public var contentConfiguration: UIListContentConfiguration = .cell()
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public init(id: String) {
        self.id = id
    }
}

public extension MKFormListField {
    
    @discardableResult
    func accessory(_ type: UITableViewCell.AccessoryType) -> Self {
        var copy = self
        copy.accessoryType = type
        return copy
    }
    
}
