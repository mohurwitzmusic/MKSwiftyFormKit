import UIKit

open class MKFormListCell: MKFormCell {
    
    open var fieldUpdateHandler: ((MKFormListCell) -> MKFormListField) = { $0.field }
    open private(set) var field = MKFormListField(id: "")
    
    open func refresh(field: MKFormListField) {
        self.field = field
        isUserInteractionEnabled =  field.displayState.isEnabled
        contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        self.accessoryType = field.accessoryType
    }
    
    open func refreshWithFieldUpdateHandler() {
        self.refresh(field: fieldUpdateHandler(self))
    }
    
    @discardableResult
    public func withFieldUpdateHandler(handler: @escaping ((MKFormListCell) -> MKFormListField)) -> Self {
        self.fieldUpdateHandler = handler
        return self
    }
    
}
