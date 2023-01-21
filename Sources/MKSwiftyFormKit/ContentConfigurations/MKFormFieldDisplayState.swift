public struct MKFormFieldDisplayState: Hashable {
    public var isEnabled: Bool = true
    public var isHidden: Bool = true
    public init(isEnabled: Bool = true, isHidden: Bool = false) {
        self.isEnabled = isEnabled
        self.isHidden = isHidden
    }
}
