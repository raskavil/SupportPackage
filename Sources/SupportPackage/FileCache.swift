import Foundation

@propertyWrapper
struct Saved<Value: Codable> {
    var wrappedValue: Value {
        get {
            let folderURL = try? FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            let fileURL = folderURL?.appendingPathComponent(fileName)
            return fileURL
                .flatMap({ FileManager.default.contents(atPath: $0.path) })
                .flatMap { try? JSONDecoder().decode(Value.self, from: $0) } ?? defaultValue
        }
        set {
            let folderURL = try? FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            let fileURL = folderURL?.appendingPathComponent(fileName)
            let data = try? JSONEncoder().encode(newValue)
            fileURL.map { try? data?.write(to: $0) }
        }
    }
    
    private let propertyName: String
    private let defaultValue: Value
    
    private var fileName: String {
        propertyName + String(describing: Value.self) + ".json"
    }
    
    init(wrappedValue defaultValue: Value, _ propertyName: String) {
        self.propertyName = propertyName
        self.defaultValue = defaultValue
    }
}
