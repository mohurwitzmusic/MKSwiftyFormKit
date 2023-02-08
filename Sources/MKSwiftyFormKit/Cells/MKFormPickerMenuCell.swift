import UIKit


@available(iOS 15, *)
open class MKFormPickerMenuCell<T: Equatable>: MKFormCell {

    public let openMenuButton = UIButton(configuration: .plain())

    public var selectionHandler: ((MKFormPickerMenuCell, T) -> Void)?
    
    open private(set) var field: MKFormPickerMenuField<T>?
        
    open func refresh(field: MKFormPickerMenuField<T>) {
        self.field = field
        isUserInteractionEnabled =  field.displayState.isEnabled
        openMenuButton.isEnabled =  field.displayState.isEnabled
        contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        openMenuButton.configuration = field.openMenuButtonConfiguration.updated(for: openMenuButton)
        let actions = field.menuItems.map { item in
            item.uiAction {[weak self] id in
                guard let self else { return }
                self.selectionHandler?(self, id)
            }
        }
        openMenuButton.menu = UIMenu(children: actions)
    }
    
    public override func setup() {
        selectionStyle = .none
        hitTestingView = openMenuButton
        configureButton()
    }

    private func configureButton() {
        addSubview(openMenuButton)
        openMenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openMenuButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            openMenuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            openMenuButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
        ])
        openMenuButton.configuration = .plain()
        openMenuButton.configuration?.imagePlacement = .trailing
        openMenuButton.configuration?.imagePadding = 5
        openMenuButton.configuration?.image = .init(systemName: "chevron.up.chevron.down")
        openMenuButton.showsMenuAsPrimaryAction = true
    }

}

public extension MKFormPickerMenuCell {
    
    @discardableResult
    func onSelection(_ handler: @escaping ((MKFormPickerMenuCell<T>, T) -> Void)) -> Self {
        selectionHandler = handler
        return self
    }
    
    @discardableResult
    func onSelection<U: AnyObject>(target: U, handler: @escaping (U, MKFormPickerMenuCell<T>, T) -> Void) -> Self {
        selectionHandler = { [weak target] cell, id in
            guard let target else { return }
            handler(target, cell, id)
        }
        return self
    }

}


fileprivate extension  MKFormPickerMenuField.MenuItem {
    
    var selectedItemImage: UIImage? {
        UIImage(systemName: "checkmark")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.blue)
    }
    
    func uiAction(selectionHandler: @escaping (T) -> Void) -> UIAction {
        let image = isSelected ? selectedItemImage : nil
        return UIAction(title: title, image: image) { _ in
            selectionHandler(id)
        }
    }
    
}

