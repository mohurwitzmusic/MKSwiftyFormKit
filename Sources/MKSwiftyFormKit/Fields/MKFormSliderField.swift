import UIKit

public struct MKFormSliderField: MKFormField, Hashable, Identifiable {
    public let id: String
    public var isDisabled = false
    public var value: Float = 0.0
    public init(id: String) {
        self.id = id
    }
}

public extension MKFormSliderField {
    init(id: String, value: Float) {
        self.id = id
        self.value = value
    }
}
