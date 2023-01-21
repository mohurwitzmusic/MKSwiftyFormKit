import UIKit

public struct MKFormLayout<SectionID: Hashable, ItemID: Hashable>: Hashable {
    
    public private(set) var sections: [SectionID] = []
    
    private var itemsDict = [SectionID : [ItemID]]()
    
    public var items: [ItemID] {
        sections
            .compactMap { itemsDict[$0] }
            .flatMap { $0 }
    }
    
    public init() { }
    
    public mutating func append(section: SectionID, items: ItemID...) {
        sections.append(section)
        itemsDict[section] = items
    }
    
    public mutating func append(sections: SectionID...) {
        self.sections.append(contentsOf: sections)
        sections.forEach { itemsDict[$0] = [] }
    }
    
    public mutating func append(items: ItemID..., to section: SectionID) {
        guard contains(section: section) else {
            fatalError("Unkown section")
        }
        itemsDict[section]?.append(contentsOf: items)
    }
    
    public func contains(section: SectionID) -> Bool {
        sections.contains(section)
    }
    
    public func contains(items: ItemID...) -> Bool {
        itemsDict.values.contains(items)
    }
    
    public func snapshot() -> NSDiffableDataSourceSnapshot<SectionID, ItemID> {
        var snapshot = NSDiffableDataSourceSnapshot<SectionID, ItemID>()
        for section in sections {
            snapshot.appendSections([section])
            snapshot.appendItems(itemsDict[section] ?? [], toSection: section)
        }
        return snapshot
    }
    
}
