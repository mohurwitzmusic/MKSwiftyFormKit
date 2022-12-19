import UIKit

public struct MKFormListField: MKFormField, UIListContentConfigurable, Hashable, Identifiable, FieldIdentifierInitializable {
    public let id: String
    public var isDisabled: Bool = false
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var contentConfiguration = UIListContentConfiguration.cell()
    public init(id: String) {
        self.id = id
    }
}
