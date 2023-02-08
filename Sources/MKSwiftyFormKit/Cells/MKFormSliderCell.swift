import UIKit
import Combine

open class MKFormSliderCell: MKFormCell {
    
    open private(set) var field = MKFormSliderField(id: "")
    open var fieldProvider: ((MKFormSliderCell) -> MKFormSliderField) = { $0.field }
    open var sliderValueChangedHandler: ((MKFormSliderCell) -> Void)?
    open var sliderTouchesEndedHandler: ((MKFormSliderCell) -> Void)?
    open var sliderTouchesBeganHandler: ((MKFormSliderCell) -> Void)?
    public let slider = UISlider()
    
    open func refresh(field: MKFormSliderField, animated: Bool) {
        self.field = field
        self.isUserInteractionEnabled = field.displayState.isEnabled
        self.slider.isEnabled = field.displayState.isEnabled
        self.slider.setValue(field.value, animated: animated)
    }
    
    open func refreshWithFieldProvider(animated: Bool) {
        refresh(field: fieldProvider(self), animated: animated)
    }

    open override func setup() {
        selectionStyle = .none
        contentView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            slider.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            slider.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            slider.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
        slider.addTarget(self, action: #selector(_sliderTouchDown), for: .touchDown)
        slider.addTarget(self, action: #selector(_sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(_sliderTouchUp), for: .touchUpInside)
        slider.addTarget(self, action: #selector(_sliderTouchUp), for: .touchUpOutside)
    }


    @objc private func _sliderValueChanged() {
        field.value = slider.value
        sliderValueChangedHandler?(self)
    }
    
    @objc private func _sliderTouchUp() {
        field.value = slider.value
        sliderTouchesEndedHandler?(self)
    }
    
    @objc private func _sliderTouchDown() {
        field.value = slider.value
        sliderTouchesBeganHandler?(self)
    }
    
}

public extension MKFormSliderCell {
    
    @discardableResult
    func onTouchesBegan<T: AnyObject>(target: T, handler: @escaping ((T, MKFormSliderCell) -> Void)) -> Self {
        self.sliderTouchesBeganHandler =  { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func onValueChanged<T: AnyObject>(target: T, handler: @escaping ((T, MKFormSliderCell) -> Void)) -> Self {
        self.sliderValueChangedHandler =  { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func onTouchesEnded<T: AnyObject>(target: T, handler: @escaping ((T, MKFormSliderCell) -> Void)) -> Self {
        self.sliderTouchesEndedHandler =  { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func withFieldProvider(fieldProvider: @escaping ((MKFormSliderCell) -> MKFormSliderField)) -> Self {
        self.fieldProvider = fieldProvider
        return self
    }
}
