
public extension Array where Element: Equatable {
    
    mutating func toggleMembership(of toggled: Element) {
        if let index = firstIndex(where: { toggled == $0 }) {
            remove(at: index)
        } else {
            append(toggled)
        }
    }
    
    mutating func removeIfPresent(_ element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
    
    func uniqueValues() -> Self {
        uniqueValues(equationFunction: { $0 == $1 })
    }

}

public extension Array {
    
    subscript(safe index: Index) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
    
    func uniqueValues(equationFunction: (Element, Element) -> Bool) -> Self {
        var returnValue: Self = []
        forEach { value in
            if !returnValue.contains(where: { equationFunction(value, $0) }) {
                returnValue.append(value)
            }
        }
        return returnValue
    }
}
