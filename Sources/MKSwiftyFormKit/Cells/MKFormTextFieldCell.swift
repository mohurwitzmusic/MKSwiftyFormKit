import UIKit

open class MKFormTextFieldCell: MKFormCell, UITextFieldDelegate {
    
    open private(set) var field = MKFormTextField(id: "")
    open var fieldProvider: ((MKFormTextFieldCell) -> MKFormTextField) = { $0.field }
    open var textFieldShouldReturnHandler: ((MKFormTextFieldCell) -> Bool)?
    open var textFieldShouldChangeCharactersInRangeHandler: ((MKFormTextFieldCell, NSRange, String) -> Bool)?
    open var textFieldDidEndEditingHandler: ((MKFormTextFieldCell) -> Void)?
    open var textFieldDidBeginEditingHandler: ((MKFormTextFieldCell) -> Void)?
    open var textFieldEditingChangedHandler: ((MKFormTextFieldCell) -> Void)?
    
    open var textField = UITextField()
    
    open func refresh(field: MKFormTextField) {
        self.field = field
        textField.configure(field.textFieldConfiguration)
        textField.isUserInteractionEnabled = field.displayState.isEnabled
        textField.isEnabled = field.displayState.isEnabled
        setNeedsUpdateConfiguration()
    }
    
    open func refreshWithFieldProvider() {
        refresh(field: fieldProvider(self))
    }
    
    public init(size: AccessoryLayout.Size = .automatic) {
        super.init(style: .default, reuseIdentifier: nil)
        switch size {
        case .automatic:
            contentView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                textField.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
                textField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
                textField.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
        case .fractional(let width):
            accessoryView = textField
            accessoryLayout.width = .fractional(width)
        case .fixed(let width):
            accessoryView = textField
            accessoryLayout.width = .fixed(width)
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    

    
    open override func setup() {
        selectionStyle = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
    }

    @objc private func textFieldValueChanged(_ sender: UITextField) {
        field.textFieldConfiguration.text = sender.text
        self.textFieldEditingChangedHandler?(self)
    }
    
    open override func updateConfiguration(using state: UICellConfigurationState) {
        if textField.superview == contentView {
            return
        }
        self.contentConfiguration = field.contentConfiguration.updated(for: state)
    }
    
}

public extension MKFormTextFieldCell {
    
    @discardableResult
    func onTextFieldShouldReturn(handler: @escaping ((MKFormTextFieldCell) -> Bool)) -> Self {
        self.textFieldShouldReturnHandler = handler
        return self
    }
    
    @discardableResult
    func onTextFieldShouldCharactersInRange(handler: @escaping ((MKFormTextFieldCell, NSRange, String) -> Bool)) -> Self {
        self.textFieldShouldChangeCharactersInRangeHandler = handler
        return self
    }
    
    @discardableResult
    func onTextFieldDidEndEditing(handler: @escaping ((MKFormTextFieldCell) -> Void)) -> Self {
        self.textFieldDidEndEditingHandler = handler
        return self
    }
    
    @discardableResult
    func onTextFieldDidBeginEditing(handler: @escaping ((MKFormTextFieldCell) -> Void)) -> Self {
        self.textFieldDidBeginEditingHandler = handler
        return self
    }
    
    @discardableResult
    func onTextFieldEditingChanged(handler: @escaping ((MKFormTextFieldCell) -> Void)) -> Self {
        self.textFieldEditingChangedHandler = handler
        return self
    }
    
}


public extension MKFormTextFieldCell {
    
    @discardableResult
    func onTextFieldShouldReturn<T: AnyObject>(target: T, handler: @escaping ((T, MKFormTextFieldCell) -> Bool)) -> Self {
        self.textFieldShouldReturnHandler = { [weak target] cell in
            guard let target else {
                cell.textField.resignFirstResponder()
                return true
            }
            return handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func onTextFieldShouldCharactersInRange<T: AnyObject>(target: T, handler: @escaping ((T, MKFormTextFieldCell, NSRange, String) -> Bool)) -> Self {
        self.textFieldShouldChangeCharactersInRangeHandler = { [weak target] cell, range, string in
            guard let target else { return true }
            return handler(target, cell, range, string)
        }
        return self
    }
    
    @discardableResult
    func onTextFieldDidEndEditing<T: AnyObject>(target: T, handler: @escaping ((T, MKFormTextFieldCell) -> Void)) -> Self {
        self.textFieldDidEndEditingHandler = { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func onTextFieldDidBeginEditing<T: AnyObject>(target: T, handler: @escaping ((T, MKFormTextFieldCell) -> Void)) -> Self {
        self.textFieldDidEndEditingHandler = { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func onTextFieldEditingChanged<T: AnyObject>(target: T, handler: @escaping ((T, MKFormTextFieldCell) -> Void)) -> Self {
        self.textFieldEditingChangedHandler = { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func withFieldProvider(fieldProvider: @escaping ((MKFormTextFieldCell) -> MKFormTextField)) -> Self {
        self.fieldProvider = fieldProvider
        return self
    }
    
}

extension MKFormTextFieldCell {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let handler = textFieldShouldReturnHandler {
            return handler(self)
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textFieldShouldChangeCharactersInRangeHandler?(self, range, string) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidEndEditingHandler?(self)
    }
}



