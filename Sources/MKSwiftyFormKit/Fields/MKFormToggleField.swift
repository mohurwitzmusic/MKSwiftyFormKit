import UIKit

public struct MKFormToggleField: MKFormField, UIListContentConfigurable, Hashable, Identifiable {
    public let id: String
    public var isDisabled = false
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var isOn: Bool = false
    public init(id: String) {
        self.id = id
    }
}

public extension MKFormToggleField {
    
    init(id: String, isOn: Bool) {
        self.init(id: id)
        self.isOn = isOn
    }

}


