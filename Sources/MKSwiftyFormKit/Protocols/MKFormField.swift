public protocol MKFormField {
    var id: String { get }
    var displayState: MKFormFieldDisplayState { get set }
}

public extension MKFormField {
    
    func enabled(_ enabled: Bool) -> Self {
        var copy = self
        copy.displayState.isEnabled = enabled
        return copy
    }
    
    func hidden(_ hidden: Bool) -> Self {
        var copy = self
        copy.displayState.isHidden = hidden
        return copy
    }
    
}
