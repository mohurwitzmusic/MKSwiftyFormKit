import UIKit

open class MKFormListCell: MKFormCell {
    
    open private(set) var field = MKFormListField(id: "")
    
    open func refresh(field: MKFormListField) {
        self.field = field
        isUserInteractionEnabled =  field.displayState.isEnabled
        contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        self.accessoryType = field.accessoryType
    }
    
}
