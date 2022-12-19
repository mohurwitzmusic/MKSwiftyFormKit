import UIKit

/// Use when you want to navigate to a detil view controller that presents a list of colors.

open class MKFormColorMenuDisclosureCell: MKFormCell {
    
    private let _imageView = UIImageView()
    
    open var selectedColor: UIColor? {
        get { _imageView.tintColor }
        set { _imageView.tintColor = newValue }
    }
    
    open func refresh(field: MKFormColorField) {
        self.isUserInteractionEnabled = !field.isDisabled
        self._imageView.isUserInteractionEnabled = !field.isDisabled
        self.contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        self.selectedColor = field.color
    }
    
    open func refresh(field: MKFormColorMenuField) {
        self.isUserInteractionEnabled = !field.isDisabled
        self._imageView.isUserInteractionEnabled = !field.isDisabled
        self.contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        self.selectedColor = field.selectedColor
    }
    
    open override func setup() {
        addSubview(_imageView)
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            _imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            _imageView.widthAnchor.constraint(equalToConstant: 32),
            _imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        _imageView.contentMode = .scaleAspectFit
        _imageView.image = .init(systemName: "circle.fill")
        accessoryType = .disclosureIndicator
    }
    
    
}
