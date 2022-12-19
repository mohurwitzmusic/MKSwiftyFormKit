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

public struct MKFormColorMenuField: MKFormField, UIListContentConfigurable {
    
    public struct MenuItem {
        public let name: String
        public let color: UIColor
        public init(name: String, color: UIColor) {
            self.name = name
            self.color = color
        }
    }
    
    public let id: String
    public var isDisabled: Bool = false
    public let menuItems: [MenuItem]
    public var selectedColor: UIColor
    public var contentConfiguration: UIListContentConfiguration = .cell()
    
    
    /// Initializes a new `MKColorMenuField` with the selected color. The menu must not be empty.
    ///
    /// **Important**: The selectedColor is not guaranteed to be one of the colors in the menu.
    ///
    /// Use the initializer `init(id:menuItems:closestMenuColorTo:)`
    /// to find the closest color in the menu.
    ///
    /// There is also equivalent view modifier `selectingClosestColor(to:)` that can be used after initialization.
    
    public init(id: String, menuItems: [MenuItem] = .systemRainbow(), selectedColor: UIColor) {
        guard menuItems.count > 0 else {
            fatalError("Color menu items cannot be empty")
        }
        self.id = id
        self.menuItems = menuItems
        self.selectedColor = selectedColor
        self.contentConfiguration.text = "Color"
    }
    
    
    /// Initializes a new `MKColorMenuField` selecting the most similar color to the colors provided.
    
    public init(id: String, menuItems: [MenuItem] = .systemRainbow(), selectingClosestColorTo color: UIColor) {
        guard menuItems.count > 0 else {
            fatalError("Color menu items cannot be empty")
        }
        self.id = id
        self.menuItems = menuItems
        let closestIndex = menuItems.map { $0.color }.firstIndex(closestTo: color)
        self.selectedColor = menuItems[closestIndex].color
        self.contentConfiguration.text = "Color"
    }
  
    /// Selects the closest color to one of the colors in the `menuItems` larray.
    
    @discardableResult
    public mutating func selectingClosestColor(to color: UIColor) -> Self {
        let index = menuItems.map { $0.color }.firstIndex(closestTo: color)
        self.selectedColor = menuItems[index].color
        return self
    }
}


public extension Array where Element == MKFormColorMenuField.MenuItem {
    
    static func systemRainbow() -> Self {
        [
        .systemGray,
        .systemRed,
        .systemOrange,
        .systemPink,
        .systemYellow,
        .systemMint,
        .systemGreen,
        .systemTeal,
        .systemBlue,
        .systemIndigo,
        .systemPurple,
        .systemCyan,
        ]
    }
    
}

public extension MKFormColorMenuField.MenuItem {
    static var systemGray: Self { .init(name: "Gray", color: .systemGray) }
    static var systemRed: Self { .init(name: "Red", color: .systemRed) }
    static var systemPink: Self { .init(name: "Pink", color: .systemPink) }
    static var systemOrange: Self { .init(name: "Orange", color: .systemOrange) }
    static var systemYellow: Self { .init(name: "Yellow", color: .systemYellow) }
    static var systemMint: Self { .init(name: "Mint", color: .systemMint) }
    static var systemGreen: Self { .init(name: "Green", color: .systemGreen)}
    static var systemTeal: Self { .init(name: "Teal", color: .systemTeal) }
    static var systemBlue: Self { .init(name: "Blue", color: .systemBlue) }
    static var systemIndigo: Self { .init(name: "Indigo", color: .systemIndigo) }
    static var systemPurple: Self { .init(name: "Purple", color: .systemPurple) }
    static var systemCyan: Self { .init(name: "Cyan", color: .systemCyan) }
    
}

