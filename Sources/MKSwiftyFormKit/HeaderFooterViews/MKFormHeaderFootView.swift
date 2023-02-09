import UIKit

public extension UITableView {
    
    func formHeader(reuseID: String, fieldProvider: ((MKFormHeaderFooterView) -> MKFormHeaderFooterField?)) -> UITableViewHeaderFooterView? {
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: reuseID) as? MKFormHeaderFooterView else { return nil }
        if let field = fieldProvider(header) {
            header.refresh(field: field)
            return header
        }
        return nil
    }
    
}

open class MKFormHeaderFooterView: UITableViewHeaderFooterView {
    
    open private(set) var field = MKFormHeaderFooterField(id: "")
    open var fieldUpdateHandler: ((MKFormHeaderFooterView) -> MKFormHeaderFooterField) = { $0.field }
    open func setup() { }
    
    open func refresh(field: MKFormHeaderFooterField) {
        self.field = field
        self.contentConfiguration = field.contentConfiguration.updated(for: configurationState)
    }
    
    open func refreshWithFieldUpdateHandler() {
        refresh(field: fieldUpdateHandler(self))
    }
    
    @discardableResult
    public func withFieldUpdateHandler(handler: @escaping ((MKFormHeaderFooterView) -> MKFormHeaderFooterField)) -> Self {
        self.fieldUpdateHandler = handler
        return self
    }

    @discardableResult
    public func withFieldUpdateHandler<T: AnyObject>(source: T, handler: @escaping ((T, MKFormHeaderFooterView) -> MKFormHeaderFooterField)) -> Self {
        fieldUpdateHandler = { [weak source] view in
            guard let source else { return .init(id: "") }
            return handler(source, view)
        }
        return self
    }
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

