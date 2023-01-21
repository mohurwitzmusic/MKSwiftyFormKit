import UIKit

open class MKFormFullWidthTextFieldCell: MKFormTextFieldCell {
    
    open var fieldProvider: ((MKFormFullWidthTextFieldCell) -> MKFormTextField)?
    
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
    
    open func refresh() {
        guard let field = fieldProvider?(self) else { return }
        self.isUserInteractionEnabled =  field.displayState.isEnabled
        textField.isEnabled =  field.displayState.isEnabled
        textField.configure(field.textField)
    }
}

public extension MKFormFullWidthTextFieldCell {
    
    @discardableResult
    func withFieldProvider<T: AnyObject>(source: T, handler: @escaping ((T, MKFormFullWidthTextFieldCell) -> MKFormTextField)) -> Self {
        fieldProvider = { [weak source] cell in
            guard let source else { return .init(id: "") }
            return handler(source, cell)
        }
        return self
    }
    
}

