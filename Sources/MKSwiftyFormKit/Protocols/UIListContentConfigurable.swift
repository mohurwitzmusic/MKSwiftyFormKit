import UIKit

public protocol UIListContentConfigurable where Self : MKFormField {
    var contentConfiguration: UIListContentConfiguration { get set }
}

public extension UIListContentConfigurable where Self : FieldIdentifierInitializable {
    init(id: String, configuration: UIListContentConfiguration) {
        self.init(id: id)
        self.contentConfiguration = configuration
    }
}

public extension UIListContentConfigurable {
    
    func title(_ text: String) -> Self {
        var copy = self
        copy.contentConfiguration.text = text
        return copy
    }
    
    func subtitle(_ text: String) -> Self {
        var copy = self
        copy.contentConfiguration.secondaryText = text
        return copy
    }
    
    func image(systemName: String) -> Self {
        var copy = self
        copy.contentConfiguration.image = .init(systemName: systemName)
        return copy
    }
    
    func image(_ image: UIImage?) -> Self {
        var copy = self
        copy.contentConfiguration.image = image
        return copy
    }
    
    func imageColor(_ color: UIColor) -> Self {
        var copy = self
        copy.contentConfiguration.imageProperties.tintColor = color
        return copy
    }
    
    func titleColor(_ color: UIColor) -> Self {
        var copy = self
        copy.contentConfiguration.textProperties.color = color
        return copy
    }
    
    func subtitleColor(_ color: UIColor) -> Self {
        var copy = self
        copy.contentConfiguration.secondaryTextProperties.color = color
        return copy
    }
    
    func titleFont(_ font: UIFont) -> Self {
        var copy = self
        copy.contentConfiguration.textProperties.font = font
        return copy
    }
    
    func subtitleFont(_ font: UIFont) -> Self {
        var copy = self
        copy.contentConfiguration.secondaryTextProperties.font = font
        return copy
    }
    
    func imageToTextPadding(_ padding: CGFloat) -> Self {
        var copy = self
        copy.contentConfiguration.imageToTextPadding = padding
        return copy
    }
    
}


