import UIKit
import Combine

open class MKFormToggleCell: MKFormCell {
    
    open private(set) var field = MKFormToggleField(id: "")
    open var fieldProvider: ((MKFormToggleCell) -> MKFormToggleField) = { $0.field }
    open var toggleValueChangedHandler: ((MKFormToggleCell) -> Void)?
    open var toggle = UISwitch()
    
    open func refresh(field: MKFormToggleField, animated: Bool) {
        self.field = field
        self.isUserInteractionEnabled =  field.displayState.isEnabled
        self.toggle.isEnabled =  field.displayState.isEnabled
        self.toggle.setOn(field.isOn, animated: animated)
        self.contentConfiguration = field.contentConfiguration.updated(for: configurationState)
    }
    
    open func refreshWithFieldProvider(animated: Bool) {
        self.refresh(field: fieldProvider(self), animated: animated)
    }

    open override func setup() {
        selectionStyle = .none
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(_valueChanged), for: .valueChanged)
    }
    
    @objc func _valueChanged() {
        field.isOn = toggle.isOn
        toggleValueChangedHandler?(self)
    }
    
}

public extension MKFormToggleCell {
    
    @discardableResult
    func onToggleValueChanged(handler: @escaping ((MKFormToggleCell) -> Void)) -> Self {
        self.toggleValueChangedHandler = handler
        return self
    }
    
    @discardableResult
    func onToggleValueChanged<T: AnyObject>(target: T, handler: @escaping ((T, MKFormToggleCell) -> Void)) -> Self {
        self.toggleValueChangedHandler =  { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func withFieldProvider(fieldProvider: @escaping ((MKFormToggleCell) -> MKFormToggleField)) -> Self {
        self.fieldProvider = fieldProvider
        return self
    }
 
}
