
public extension Swift.Collection where Element: AdditiveArithmetic {
    
    var sum: Element {
        guard var returnValue = first else { return .zero }
        dropFirst().forEach { returnValue += $0 }
        return returnValue
    }
}
