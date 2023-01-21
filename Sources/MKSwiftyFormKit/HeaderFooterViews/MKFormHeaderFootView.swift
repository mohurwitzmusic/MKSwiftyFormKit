import UIKit

open class MKFormHeaderFooterView: UITableViewHeaderFooterView {
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    open var fieldProvider: ((MKFormHeaderFooterView) -> MKFormHeaderFooter)?
    
    open func setup() { }
    
    open func refresh() {
        guard let field = fieldProvider?(self) else { return }
        self.refresh(field: field)
    }
    
    open func refresh(field: MKFormHeaderFooter) {
        self.contentConfiguration = field.contentConfiguration.updated(for: configurationState)
    }
    
    @discardableResult
    public func withFieldProvider<T: AnyObject>(source: T, handler: @escaping ((T, MKFormHeaderFooterView) -> MKFormHeaderFooter)) -> Self {
        fieldProvider = { [weak source] view in
            guard let source else { return .init(id: "") }
            return handler(source, view)
        }
        return self
    }
}

