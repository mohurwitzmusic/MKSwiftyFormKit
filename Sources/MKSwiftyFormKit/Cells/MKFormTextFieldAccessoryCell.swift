import UIKit

open class MKFormTextFieldAccessoryCell: MKFormTextFieldCell {
    
    open var fieldProvider: ((MKFormTextFieldAccessoryCell) -> MKFormAccessoryTextField)?
    
    open func refresh() {
        guard let field = fieldProvider?(self) else { return }
        isUserInteractionEnabled = field.displayState.isEnabled
        textField.isEnabled = field.displayState.isEnabled
        contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        textField.configure(field.textField)
        switch field.textFieldWidth {
        case .fractional(let multiplier):
            accessoryLayout = .init(width: .fractional(multiplier))
        case .fixed(let constant):
            accessoryLayout = .init(width: .fixed(constant))
        }
    }
    
    public override func setup() {
        super.setup()
        self.accessoryView = textField
    }
}

public extension MKFormTextFieldAccessoryCell {
    
    @discardableResult
    func withFieldProvider<T: AnyObject>(source: T, handler: @escaping ((T, MKFormTextFieldAccessoryCell) -> MKFormAccessoryTextField)) -> Self {
        fieldProvider = { [weak source] cell in
            guard let source else { return .init(id: "") }
            return handler(source, cell)
        }
        return self
    }
    
    
}
