import UIKit

public struct MKFormPickerMenuField<T: Equatable>: Equatable, MKFormField, Identifiable, UIListContentConfigurable {
    
    public struct MenuItem: Equatable {
        public let id: T
        public let title: String
        public let isSelected: Bool
        public init(id: T, title: String, isSelected: Bool) {
            self.id = id
            self.title = title
            self.isSelected = isSelected
        }
    }
    
    public let id: String
    public var displayState = MKFormFieldDisplayState()
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var openMenuButtonConfiguration = UIButton.Configuration.plain()
    public  var menuItems = [MenuItem]()
    public init(id: String) {
        self.id = id
        openMenuButtonConfiguration.imagePlacement = .trailing
        openMenuButtonConfiguration.imagePadding = 5
        openMenuButtonConfiguration.image = .init(systemName: "chevron.up.chevron.down")
    }
}

public extension MKFormPickerMenuField {
    
    func buttonTitle(_ title: String) -> Self {
        var copy = self
        copy.openMenuButtonConfiguration.title = title
        return copy
    }
    
}

public extension MKFormPickerMenuField where T : BinaryInteger, T : Comparable, T : Strideable, T.Stride == Int {
    
    static func numberPicker(id: String, range: ClosedRange<T>, selected: T) -> MKFormPickerMenuField<T> {
        guard range.contains(selected) else {
            fatalError("index \(selected) out of bounds: range=\(range)")
        }
        var field = MKFormPickerMenuField<T>(id: id)
        field.menuItems = range.map { value in
                .init(id: value, title: "\(value)", isSelected: value == selected)
        }
        field.openMenuButtonConfiguration.title = "\(selected)"
        return field
    }
    
}



extension MKFormPickerMenuField.MenuItem : Identifiable where T : Hashable {
    public typealias ID = T
}

extension MKFormPickerMenuField.MenuItem : Hashable where T : Hashable { }

extension MKFormPickerMenuField: Hashable where T : Hashable { }

