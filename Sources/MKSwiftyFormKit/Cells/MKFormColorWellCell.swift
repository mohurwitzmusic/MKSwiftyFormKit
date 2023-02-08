import UIKit
import Combine

open class MKFormColorWellCell: MKFormCell {
    
    private var lastSentColor: UIColor?
    private let tapGesture = UITapGestureRecognizer()
    
    open private(set) var field = MKFormColorField(id: "", color: .gray)
    open var fieldProvider: ((MKFormColorWellCell) -> MKFormColorField) = { $0.field }
    open var colorWell = UIColorWell()
    open var colorWellValueChangedHandler: ((MKFormColorWellCell) -> Void)?

    open func refresh(field: MKFormColorField) {
        self.field = field
        self.isUserInteractionEnabled =  field.displayState.isEnabled
        self.colorWell.isEnabled =  field.displayState.isEnabled
        self.contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        self.colorWell.selectedColor = field.color
    }
    
    open func refreshWithFieldProvider() {
        self.refresh(field: fieldProvider(self))
    }
    
    open override func setup() {
        selectionStyle = .none
        accessoryView = colorWell
        colorWell.supportsAlpha = false
        colorWell.addTarget(self, action: #selector(_colorWellValueChanged), for: .valueChanged)
    }
    
    @objc private func _colorWellValueChanged() {
        if let color = colorWell.selectedColor {
            field.color = color
        }
        guard let color = colorWell.selectedColor else { return }
        if let lastSentColor, lastSentColor.isAlmostEqual(to: color) { return }
        lastSentColor = colorWell.selectedColor
        colorWellValueChangedHandler?(self)
    }

}

public extension MKFormColorWellCell {
    
    @discardableResult
    func setSupportsAlpha(_ supportsAlpha: Bool) -> Self {
        self.colorWell.supportsAlpha = supportsAlpha
        return self
    }
    
    @discardableResult
    func onColorWellValueChanged<T: AnyObject>(target: T, handler: @escaping ((T, MKFormColorWellCell) -> Void)) -> Self {
        self.colorWellValueChangedHandler =  { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
    @discardableResult
    func withFieldProvider(fieldProvider: @escaping ((MKFormColorWellCell) -> MKFormColorField)) -> Self {
        self.fieldProvider = fieldProvider
        return self
    }
    
}

public extension MKFormColorWellCell {
    
    @discardableResult
    func onColorWellValueChanged<T: ObservableObject>(target: T, handler: @escaping ((T, MKFormColorWellCell) -> Void)) -> Self {
        self.colorWellValueChangedHandler =  { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }

}


fileprivate extension UIColor {
    
    func isAlmostEqual(to other: UIColor) -> Bool {
        return self.getRGBA().isAlmostEqual(to: other.getRGBA())
    }
    
    private func getRGBA() -> RGBA {
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(1.0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return .init(r: r, g: g, b: b, a: a)
    }
    
    private struct RGBA: Equatable {
        let r: CGFloat
        let g: CGFloat
        let b: CGFloat
        let a: CGFloat
        
        func isAlmostEqual(to other: RGBA) -> Bool {
            let delta = CGFloat(0.01)
            if abs(self.r - other.r) < delta,
               abs(self.g - other.g) < delta,
               abs(self.b - other.b) < delta,
               abs(self.a - other.a) < delta {
                return true
            }
            return false
        }
    }
}

