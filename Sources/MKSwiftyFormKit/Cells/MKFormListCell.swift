import UIKit

open class MKFormListCell: MKFormCell {
    
    open func refresh(field: MKFormListField) {
        isUserInteractionEnabled = !field.isDisabled
        contentConfiguration = field.contentConfiguration.updated(for: configurationState)
    }
    
}
