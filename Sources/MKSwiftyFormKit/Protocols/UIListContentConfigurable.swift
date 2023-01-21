import UIKit

public protocol UIListContentConfigurable {
    var contentConfiguration: UIListContentConfiguration { get set }
}


public extension UIListContentConfigurable {
    
    @discardableResult
    func baseConfiguration(_ configuration: UIListContentConfiguration) -> Self {
        var config = configuration
        var copy = self
        config.text = self.contentConfiguration.text
        config.secondaryText = self.contentConfiguration.secondaryText
        config.image = self.contentConfiguration.image
        copy.contentConfiguration = config
        return copy
    }
    
    @discardableResult
    func title(_ text: String?) -> Self {
        var copy = self
        copy.contentConfiguration.text = text
        return copy
    }
    
    @discardableResult
    func subtitle(_ text: String?) -> Self {
        var copy = self
        copy.contentConfiguration.secondaryText = text
        return copy
    }
    
    @discardableResult
    func image(systemName: String) -> Self {
        var copy = self
        copy.contentConfiguration.image = .init(systemName: systemName)
        return copy
    }
    
    @discardableResult
    func image(_ image: UIImage?) -> Self {
        var copy = self
        copy.contentConfiguration.image = image
        return copy
    }
    
    @discardableResult
    func imageColor(_ color: UIColor) -> Self {
        var copy = self
        copy.contentConfiguration.imageProperties.tintColor = color
        return copy
    }
    
    @discardableResult
    func titleColor(_ color: UIColor) -> Self {
        var copy = self
        copy.contentConfiguration.textProperties.color = color
        return copy
    }
    
    @discardableResult
    func subtitleColor(_ color: UIColor) -> Self {
        var copy = self
        copy.contentConfiguration.secondaryTextProperties.color = color
        return copy
    }
    
    @discardableResult
    func titleFont(_ font: UIFont) -> Self {
        var copy = self
        copy.contentConfiguration.textProperties.font = font
        return copy
    }
    
    @discardableResult
    func subtitleFont(_ font: UIFont) -> Self {
        var copy = self
        copy.contentConfiguration.secondaryTextProperties.font = font
        return copy
    }
    
    @discardableResult
    func imageToTextPadding(_ padding: CGFloat) -> Self {
        var copy = self
        copy.contentConfiguration.imageToTextPadding = padding
        return copy
    }
    
}


