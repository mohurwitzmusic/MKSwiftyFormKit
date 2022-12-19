import UIKit

public struct MKFormColorPalletePickerField: MKFormField, UIListContentConfigurable {
    public let id: String
    public var isDisabled: Bool = false
    public var selectedColor: UIColor
    public var colorPallete = [String:UIColor]()
    public var contentConfiguration: UIListContentConfiguration = .cell()
    public init(id: String, selectedColor: UIColor) {
        self.id = id
        self.selectedColor = selectedColor
    }
}
