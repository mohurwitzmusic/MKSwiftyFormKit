import UIKit

/// Use as an alternative to `MKFormColorWellCell` when you want to manually present a `UIColorPickerViewController`.
/// Configure the `colorButtonTappedHandler` to receive an event when the button is tapped, and  present your view controller.

open class MKFormColorPickerCell: MKFormCell {
    
    private let colorWell = UIColorWell()
    
    open var colorButonTappedHandler: ((MKFormColorPickerCell) -> Void)?
    
    open var selectedColor: UIColor? {
        get { colorWell.selectedColor }
        set { colorWell.selectedColor = newValue }
    }
    
    open var fieldProvider: ((MKFormColorPickerCell) -> MKFormColorField)?
    
    open func refresh() {
        guard let field = fieldProvider?(self) else { return }
        self.isUserInteractionEnabled = field.displayState.isEnabled
        self.colorWell.isEnabled =  field.displayState.isEnabled
        self.contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        self.colorWell.selectedColor = field.color
    }
    
    open override func setup() {
        selectionStyle = .none
        accessoryView = colorWell
        colorWell.isUserInteractionEnabled = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recognizeTapGesture))
        addGestureRecognizer(tapGesture)
    }
    
    @discardableResult
    open func onColorButtonTapped(_ handler: @escaping ((MKFormColorPickerCell) -> Void)) -> Self {
        self.colorButonTappedHandler = handler
        return self
    }
    
    @discardableResult
    open func withFieldProvider<T: AnyObject>(source: T, handler: @escaping ((T, MKFormColorPickerCell) -> MKFormColorField)) -> Self {
        fieldProvider = { [weak source] cell in
            guard let source else { return .init(id: "", color: .gray) }
            return handler(source, cell)
        }
        return self
    }
    
     @objc private func recognizeTapGesture(_ gesture: UITapGestureRecognizer) {
         let tapX = gesture.location(in: self).x
         let isMostlyCoveringColorPicker = tapX >= colorWell.frame.minX
         if isMostlyCoveringColorPicker {
             colorButonTappedHandler?(self)
         }
     }
}
