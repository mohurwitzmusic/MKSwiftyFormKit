import UIKit

open class MKFormTextFieldAccessoryCell: MKFormTextFieldCell {
    
    public override func setup() {
        super.setup()
        self.accessoryView = textField
    }
}

public extension MKFormTextFieldAccessoryCell {
    
    func refresh(field: MKFormAccessoryTextField) {
        isUserInteractionEnabled = !field.isDisabled
        textField.isEnabled = !field.isDisabled
        contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        textField.configure(field.textField)
    }
    
}
