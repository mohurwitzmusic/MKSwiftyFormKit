import UIKit


open class MKFormColorMenuViewController: UITableViewController {

    open var field: MKFormColorMenuField {
        didSet {
            refresh()
        }
    }
    open var selectionHandler: ((UIColor) -> Void)?
    open var viewWillDisappearHandler: ((UIColor) -> Void)?
    
    open var supportsUndo: Bool
    
    public init(field: MKFormColorMenuField, supportsUndo: Bool = true, style: UITableView.Style = .insetGrouped) {
        self.field = field
        self.supportsUndo = supportsUndo
        super.init(style: style)
        self.title = "Color"
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }

    @discardableResult
    open func onSelection(_ handler: ((UIColor) -> Void)?) -> Self {
        self.selectionHandler = handler
        return self
    }
    
    @discardableResult
    open func onViewWillDisappear(_ handler: ((UIColor) -> Void)?) -> Self {
        self.viewWillDisappearHandler = handler
        return self
    }
    
    private let _undoManager = UndoManager()
    
    open override var undoManager: UndoManager? {
        _undoManager
    }

    private lazy var undoButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .undo)
        button.primaryAction = UIAction { [weak self] _ in self?.undoManager?.undo() }
        return button
    }()
    
    private lazy var redoButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .redo)
        button.primaryAction = UIAction { [weak self] _ in self?.undoManager?.redo() }
        return button
    }()
    
 
    open override func viewDidLoad() {
        super.viewDidLoad()
        toolbarItems = [undoButton, redoButton]
        refresh()
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        field.menuItems.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let menuItem = field.menuItems[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.image = .init(systemName: "circle.fill")
        content.imageProperties.tintColor = menuItem.color
        content.text = menuItem.name
        cell.contentConfiguration = content
        if menuItem.color == field.selectedColor {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.delegate?.tableView?(tableView, didDeselectRowAt:indexPath)
    }
    
    open override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let item = field.menuItems[indexPath.row]
        select(item.color)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearHandler?(field.selectedColor)
    }
    
    private func refresh() {
        tableView.reloadData()
        toolbarItems = supportsUndo ? [undoButton, redoButton] : []
        undoButton.isEnabled = _undoManager.canUndo
        redoButton.isEnabled = _undoManager.canRedo
    }
    
    private func select(_ color: UIColor) {
        if supportsUndo {
            let oldSelection = self.field.selectedColor
            _undoManager.registerUndo(withTarget: self) {
                $0.select(oldSelection)
            }
        }
        self.field.selectedColor = color
        selectionHandler?(color)
    }
    
}


