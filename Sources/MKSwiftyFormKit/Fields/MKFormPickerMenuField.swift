import UIKit

public struct MKFormPickerMenuField<T: Equatable>: MKFormField, Identifiable, UIListContentConfigurable {
    
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
    public var isDisabled = false
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

public extension MKFormPickerMenuField where T : CaseIterable & CustomStringConvertible {
    
    static func allCases(id: String, selected: T) -> MKFormPickerMenuField<T> {
        guard T.allCases.contains(selected) else {
            fatalError("Selected item \(selected) not contained in allCases of \(T.self)")
        }
        var field = Self(id: id)
        field.menuItems = T.allCases.map { element in
                .init(id: element, title: element.description, isSelected: selected == element)
        }
        field.openMenuButtonConfiguration.title = "\(selected)"
        return field
    }
}


extension MKFormPickerMenuField.MenuItem : Identifiable where T : Hashable {
    
    
}
