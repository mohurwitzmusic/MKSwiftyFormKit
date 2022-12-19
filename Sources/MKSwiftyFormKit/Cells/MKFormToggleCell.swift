import UIKit
import Combine

open class MKFormToggleCell: MKFormCell {
    
    open var toggle = UISwitch()
    open var toggleValueChangedHandler: ((MKFormToggleCell) -> Void)?
    
    open func refresh(field: MKFormToggleField, animated: Bool) {
        self.isUserInteractionEnabled = !field.isDisabled
        self.toggle.isEnabled = !field.isDisabled
        self.toggle.setOn(field.isOn, animated: animated)
        self.contentConfiguration = field.contentConfiguration.updated(for: configurationState)
    }

    open override func setup() {
        selectionStyle = .none
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(_valueChanged), for: .valueChanged)
    }
    
    @objc func _valueChanged() {
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
    
}
