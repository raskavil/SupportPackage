import Foundation

public struct FailableDecodable<T: Decodable>: Decodable {
    
    public let value: T?
    
    public init(from decoder: Decoder) throws {
        value = try? decoder.singleValueContainer().decode(T.self)
    }
}
