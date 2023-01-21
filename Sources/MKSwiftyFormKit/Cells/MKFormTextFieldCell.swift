import UIKit

open class MKFormTextFieldCell: MKFormCell, UITextFieldDelegate {
    
    open var textField = UITextField()
    public var textFieldShouldReturnHandler: ((MKFormTextFieldCell) -> Bool)?
    public var textFieldShouldChangeCharactersInRangeHandler: ((MKFormTextFieldCell, NSRange, String) -> Bool)?
    public var textFieldDidEndEditingHandler: ((MKFormTextFieldCell) -> Void)?
    public var textFieldDidBeginEditingHandler: ((MKFormTextFieldCell) -> Void)?
    public var textFieldEditingChangedHandler: ((MKFormTextFieldCell) -> Void)?
    
    open override func setup() {
        selectionStyle = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
    }

    @objc private func textFieldValueChanged(_ sender: UITextField) {
        self.textFieldEditingChangedHandler?(self)
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



