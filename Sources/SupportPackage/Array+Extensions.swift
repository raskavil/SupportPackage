
extension Array where Element: Equatable {
    
    mutating func toggleMembership(of toggled: Element) {
        if let index = firstIndex(where: { toggled == $0 }) {
            remove(at: index)
        } else {
            append(toggled)
        }
    }
    
    public func uniqueValues() -> Self {
        uniqueValues(equationFunction: { $0 == $1 })
    }
    
}

extension Array {
    
    public subscript(safe index: Index) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
    
    public func uniqueValues(equationFunction: (Element, Element) -> Bool) -> Self {
        var returnValue: Self = []
        forEach { value in
            if !returnValue.contains(where: { equationFunction(value, $0) }) {
                returnValue.append(value)
            }
        }
        return returnValue
    }
}
