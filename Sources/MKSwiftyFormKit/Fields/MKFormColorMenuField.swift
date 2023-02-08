import UIKit

public struct MKFormColorMenuField: MKFormField, UIListContentConfigurable {
    
    public struct MenuItem: Equatable {
        let name: String
        let color: UIColor
        public init(name: String, color: UIColor) {
            self.name = name
            self.color = color
        }
    }
    
    public let id: String
    public var displayState = MKFormFieldDisplayState()
    public var menuItems = [MenuItem]()
    public var selectedColor = UIColor.gray
    public var contentConfiguration = UIListContentConfiguration.cell()
    
    public init(id: String, menuItems: [MenuItem], selectedColor: UIColor) {
        self.id = id
        self.selectedColor = selectedColor
        self.menuItems = menuItems
    }
    
    public init(id: String, menuItems: [MenuItem], selectingClosestColorTo color: UIColor) {
        self.id = id
        self.selectedColor = .gray
        self.menuItems = menuItems
        let copy = self.selectingClosestColor(to: color)
        self.selectedColor = copy.selectedColor
    }
    
    public func selectingClosestColor(to color: UIColor) -> Self {
        guard menuItems.count > 0 else {
            return self
        }
        var copy = self
        let index = menuItems.map { $0.color }.firstIndex(closestTo: color)
        copy.selectedColor = menuItems[index].color
        return copy
    }
}

//MARK: System Colors

public extension MKFormColorMenuField.MenuItem {
    static let systemGray = Self(name: "Gray", color: .systemGray)
    static let systemRed = Self(name: "Red", color: .systemRed)
    static let systemPink = Self(name: "Pink", color: .systemPink)
    static let systemOrange = Self(name: "Orange", color: .systemOrange)
    static let systemBrown = Self(name: "Brown", color: .systemBrown)
    static let systemYellow = Self(name: "Yellow", color: .systemYellow)
    static let systemGreen = Self(name: "Green", color: .systemGreen)
    static let systemMint = Self(name: "Mint", color: .systemMint)
    static let systemTeal = Self(name: "Teal", color: .systemTeal)
    static let systemBlue = Self(name: "Blue", color: .systemBlue)
    static let systemCyan = Self(name: "Cyan", color: .systemCyan)
    static let systemIndigo = Self(name: "Indigo", color: .systemIndigo)
    static let systemPurple = Self(name: "Purple", color: .systemPurple)
}

public extension Array where Element == MKFormColorMenuField.MenuItem {
    static func systemRainbow() -> [Element] {[
        .systemGray,
        .systemRed,
        .systemPink,
        .systemOrange,
        .systemBrown,
        .systemYellow,
        .systemGreen,
        .systemMint,
        .systemTeal,
        .systemBlue,
        .systemCyan,
        .systemIndigo,
        .systemPurple
    ]}
}


fileprivate extension Array where Element == UIColor {
    func firstIndex(closestTo color: UIColor) -> Int {
        var closestColorIndex = 0
        var closestColorDistance: CGFloat = .greatestFiniteMagnitude
        let thisRGB = color.getRGB()
        for (i, color) in self.enumerated() {
            let otherRGB = color.getRGB()
            let rDiff = thisRGB.r - otherRGB.r
            let gDiff = thisRGB.g - otherRGB.g
            let bDiff = thisRGB.b - otherRGB.b
            let distance = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
            if distance < closestColorDistance {
                closestColorIndex = i
                closestColorDistance = distance
            }
        }
        return closestColorIndex
    }
}

fileprivate extension UIColor {
    func getRGB() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
}

