
public struct Lens<Whole, Part> {
    public let get: (Whole) -> Part
    public let set: (Part, Whole) -> Whole
    
    public init(get: @escaping (Whole) -> Part, set: @escaping (Part, Whole) -> Whole) {
        self.get = get
        self.set = set
    }
}
