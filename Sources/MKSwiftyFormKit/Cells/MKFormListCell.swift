import UIKit

open class MKFormListCell: MKFormCell {
    
    open var fieldProvider: ((MKFormListCell) -> MKFormListField)?
    
    open func refresh() {
        guard let field = fieldProvider?(self) else { return }
        isUserInteractionEnabled =  field.displayState.isEnabled
        contentConfiguration = field.contentConfiguration.updated(for: configurationState)
        self.accessoryType = field.accessoryType
    }
    
    
}

public extension MKFormListCell {
    
    @discardableResult
    func withFieldProvider<T: AnyObject>(source: T, handler: @escaping ((T, MKFormListCell) -> MKFormListField)) -> Self {
        fieldProvider = { [weak source] cell in
            guard let source else { return .init(id: "") }
            return handler(source, cell)
        }
        return self
    }
    
}
