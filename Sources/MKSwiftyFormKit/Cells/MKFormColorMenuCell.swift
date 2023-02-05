import UIKit

/// A cell for displaying a menu of predefined colors.
///
/// The cell defines an enum, `InteractionMode`, which will change the behavior of the
/// cell. *Note: This must be specified in the cell's initializer and cannot be changed once set.*
///
/// 1. `popupMenu`
///
/// Use this mode when you want to allow the user to directly select a color in the cell. A pop-up `UIMenu` will be installed
/// into the cell's accessory button which, when tapped, will open a  menu displaying the list of colors.
/// Clients can get notified of the selection using the `selectionHandler` property on the cell.
///
/// 2. `navigatesToDetail`
///
/// Use this mode to indicate that tapping the cell will navigate the user to a new screen to
/// select the color. The cell's accessory button will have no behavior. Instead, the cell will
/// additionally show a `detailDisclosure` accessory indicating that the cell is used for navigation.
/// Clients should respond to cell taps using standard `UITableViewDelegate` methods
/// and manually navigate the user to the new screen.
///

open class MKFormColorMenuCell : MKFormCell {
    
    private let menuButton = UIButton(configuration: .plain())
    
    public enum InteractionMode: Equatable {
        case popupMenu
        case navigatesToDetail
    }
    
    public let interactionMode: InteractionMode
    open var selectionHandler: ((MKFormColorMenuCell) -> Void)?
    
    open private(set) var field = MKFormColorMenuField(id: "", menuItems: [], selectedColor: .gray)
    
    open var selectedColor: UIColor {
        get  { field.selectedColor }
        set {
            field.selectedColor = newValue
            menuButton.configuration?.baseForegroundColor = selectedColor
        }
    }
   
    public init(interactionMode: InteractionMode) {
        self.interactionMode = interactionMode
        super.init(style: .default, reuseIdentifier: nil)
        configureMenuButton()
        refresh(field: field)
    }
    
    public func refresh(field: MKFormColorMenuField) {
        self.field = field
        menuButton.configuration?.baseForegroundColor = field.selectedColor
        let menuActions = field.menuItems.map { menuItem in
            menuItem.menuAction { [weak self] color in
                self?.selectedColor = color
                guard let self else { return }
                self.selectionHandler?(self)
            }
        }
        menuButton.menu = .init(title: "Color", children: menuActions)
        contentConfiguration = field.contentConfiguration
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureMenuButton() {
        menuButton.configuration?.image = .init(systemName: "circle.fill")
        switch interactionMode {
        case .popupMenu:
            selectionStyle = .none
            accessoryView = menuButton
            menuButton.isUserInteractionEnabled = true
            menuButton.showsMenuAsPrimaryAction = true
            accessoryLayout.width = .fixed(27)
            menuButton.isEnabled = field.displayState.isEnabled
            menuButton.isUserInteractionEnabled = field.displayState.isEnabled
        case .navigatesToDetail:
            selectionStyle = .default
            accessoryType = .disclosureIndicator
            menuButton.isUserInteractionEnabled = false
            addSubview(menuButton)
            menuButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                menuButton.widthAnchor.constraint(equalToConstant: 32),
                menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
            ])
        }
    }

    
    @discardableResult
    public func onSelection(_ handler: @escaping ((MKFormColorMenuCell) -> Void)) -> Self {
        selectionHandler = handler
        return self
    }
    
    @discardableResult
    public func onSelection<T: AnyObject>(target: T, handler: @escaping ((T, MKFormColorMenuCell) -> Void)) -> Self {
        self.selectionHandler = { [weak target] cell in
            guard let target else { return }
            handler(target, cell)
        }
        return self
    }
    
}

fileprivate extension MKFormColorMenuField.MenuItem {
    
    func menuAction(handler: ((UIColor) -> ())?) -> UIAction {
        let image = UIImage(systemName: "circle.fill")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(color)
        return .init(title: name, image: image) { action in
            handler?(color)
        }
    }
}

