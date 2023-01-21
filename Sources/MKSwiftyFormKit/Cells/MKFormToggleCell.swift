import UIKit
import Combine

open class MKFormToggleCell: MKFormCell {
    
    open var toggle = UISwitch()
    open var toggleValueChangedHandler: ((MKFormToggleCell) -> Void)?
    open var fieldProvider: ((MKFormToggleCell) -> MKFormToggleField)?
    
    open func refresh(animated: Bool) {
        guard let field = self.fieldProvider?(self) else { return }
        self.isUserInteractionEnabled =  field.displayState.isEnabled
        self.toggle.isEnabled =  field.displayState.isEnabled
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
    
    @discardableResult
    func withFieldProvider<T: AnyObject>(source: T, handler: @escaping ((T, MKFormToggleCell) -> MKFormToggleField)) -> Self {
        self.fieldProvider = { [weak source] cell in
            guard let source else { return .init(id: "", isOn: false) }
            return handler(source, cell)
        }
        return self
    }
    
}
