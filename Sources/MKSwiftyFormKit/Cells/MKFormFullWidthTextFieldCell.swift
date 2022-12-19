import UIKit

open class MKFormFullWidthTextFieldCell: MKFormTextFieldCell {
    
    open override func setup() {
        super.setup()
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            textField.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    open func refresh(field: MKFormTextField) {
        self.isUserInteractionEnabled = !field.isDisabled
        textField.isEnabled = !field.isDisabled
        textField.configure(field.textField)
    }
}



