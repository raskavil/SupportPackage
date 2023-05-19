
extension Array where Element: Equatable {
    
    mutating func toggleMembership(of toggled: Element) {
        if let index = firstIndex(where: { toggled == $0 }) {
            remove(at: index)
        } else {
            append(toggled)
        }
    }
    
}

extension Array {
    
    public subscript(safe index: Index) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
