import UIKit

/// Use `MKColorMenuField` when you want to display a menu of predefined `UIColor`.
/// You can use this field in conjunction with `MKColorMenuViewController` to present
/// a view controller for displaying and selecting the color.
///
/// Each item in the menu must have a name that describes the color.
///
/// ````
/// let menuItem = MKColorMenuField(name: "Red", color: .systemRed)
/// ````
///
/// A number of predefined colors are available as extensions on `MKColorMenuField.MenuItem`,
/// as well as on static methods on `Array<MKFormColorMenuField.MenuItem>`.

public struct MKFormColorMenuField: Hashable, MKFormField, UIListContentConfigurable {
    
    public struct MenuItem: Hashable {
        public let name: String
        public let color: UIColor
        public init(name: String, color: UIColor) {
            self.name = name
            self.color = color
        }
    }
    
    public let id: String
    public var displayState = MKFormFieldDisplayState()

    /// A list of available colors,  each with a descriptive name for the color.
    
    public let menuItems: [MenuItem]
    public var selectedColor: UIColor
    public var contentConfiguration: UIListContentConfiguration = .cell()
    
    
    /// Initializes a new `MKColorMenuField` with the selected color. `menuItems` must not be empty.
    ///
    /// **Important**:  `selectedColor` is not guaranteed to be one of the colors in the menu. Use the view modifier
    /// `selectingClosestColor(to:)` to assign the closest color to one of the colors in the menu.
        
    public init(id: String, menuItems: [MenuItem] = .systemRainbow(), selectedColor: UIColor) {
        guard menuItems.count > 0 else {
            fatalError("Color menu items cannot be empty")
        }
        self.id = id
        self.menuItems = menuItems
        self.selectedColor = selectedColor
    }
    
    
    /// Initializes a new `MKColorMenuField`, automatically selecting the first color in the menu.
    /// `menuItems` must not be empty.
    ///
    /// After initialization, use the view modifer
    /// `selectingClosestColor(to:)` to assign the closest color to one of the colors in the menu.
    
    public init(id: String, menuItems: [MenuItem] = .systemRainbow()) {
        guard menuItems.count > 0 else {
            fatalError("Color menu items cannot be empty")
        }
        self.id = id
        self.menuItems = menuItems
        self.selectedColor = menuItems.first!.color
    }
  
    /// Sets `selectedColor` to the closest color in `menuItems`.
    
    @discardableResult
    public func selectingClosestColor(to color: UIColor) -> Self {
        var copy = self
        let index = menuItems.map { $0.color }.firstIndex(closestTo: color)
        copy.selectedColor = menuItems[index].color
        return copy
    }
}


public extension Array where Element == MKFormColorMenuField.MenuItem {
    
    static func systemRainbow() -> Self {
        [
        .systemGray,
        .systemRed,
        .systemPink,
        .systemOrange,
        .systemBrown,
        .systemYellow,
        .systemGreen,
        .systemMint,
        .systemTeal,
        .systemCyan,
        .systemBlue,
        .systemIndigo,
        .systemPurple,
        ]
    }
    
}

public extension MKFormColorMenuField.MenuItem {
    static var systemGray: Self { .init(name: "Gray", color: .systemGray) }
    static var systemRed: Self { .init(name: "Red", color: .systemRed) }
    static var systemPink: Self { .init(name: "Pink", color: .systemPink) }
    static var systemOrange: Self { .init(name: "Orange", color: .systemOrange) }
    static var systemBrown: Self { .init(name: "Brown", color: .systemBrown)}
    static var systemYellow: Self { .init(name: "Yellow", color: .systemYellow) }
    static var systemMint: Self { .init(name: "Mint", color: .systemMint) }
    static var systemGreen: Self { .init(name: "Green", color: .systemGreen)}
    static var systemTeal: Self { .init(name: "Teal", color: .systemTeal) }
    static var systemBlue: Self { .init(name: "Blue", color: .systemBlue) }
    static var systemIndigo: Self { .init(name: "Indigo", color: .systemIndigo) }
    static var systemPurple: Self { .init(name: "Purple", color: .systemPurple) }
    static var systemCyan: Self { .init(name: "Cyan", color: .systemCyan) }
}

