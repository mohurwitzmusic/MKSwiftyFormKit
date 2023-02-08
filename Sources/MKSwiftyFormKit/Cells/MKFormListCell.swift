import UIKit

open class MKFormListCell: MKFormCell {
    
    open var fieldProvider: ((MKFormListCell) -> MKFormListField) = { $0.field }
    open private(set) var field = MKFormListField(id: "")
    
    open func refresh(field: MKFormListField) {
        self.field = field
        isUserInteractionEnabled =  field.displayState.isEnabled
        contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        self.accessoryType = field.accessoryType
    }
    
    open func refreshWithFieldProvider() {
        self.refresh(field: fieldProvider(self))
    }
    
    @discardableResult
    public func withFieldProvider(fieldProvider: @escaping ((MKFormListCell) -> MKFormListField)) -> Self {
        self.fieldProvider = fieldProvider
        return self
    }
    
}
