import Foundation
import CloudKit

private let contentsKey = "dataContents"

public extension Encodable {
    
    var record: CKRecord? {
        let record = CKRecord(recordType: String.init(describing: Self.self))
        do {
            let data = try JSONEncoder().encode(self)
            record[contentsKey] = data
            return record
        } catch {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
}

public extension Decodable {
    
    init?(from record: CKRecord) throws {
        guard
            record.recordType == String.init(describing: Self.self),
            let data = record[contentsKey] as? Data
        else { return nil }
        
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}
