import UIKit

public struct MKFormHeaderFooterField: Identifiable, Hashable, UIListContentConfigurable {
    
    public let id: String
    public var contentConfiguration: UIListContentConfiguration
    
    public init(id: String) {
        self.id = id
        self.contentConfiguration = .groupedHeader()
        contentConfiguration.imageProperties.preferredSymbolConfiguration = .init(scale: .small)
        contentConfiguration.imageToTextPadding = 5
    }
    
}

