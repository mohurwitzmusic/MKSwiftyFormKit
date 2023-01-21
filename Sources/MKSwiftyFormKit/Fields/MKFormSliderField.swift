import UIKit

public struct MKFormSliderField: MKFormField, Hashable, Identifiable {
    public let id: String
    public var displayState = MKFormFieldDisplayState()
    public var value: Float = 0.0
    public init(id: String, value: Float = 0.00) {
        self.id = id
        self.value = value
    }
}
