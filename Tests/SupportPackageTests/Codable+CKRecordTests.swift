import XCTest
@testable import SupportPackage

class CodableCKRecordTests: XCTestCase {
    
    func testEncodingAndDecoding() {
        let testValue = "Hello, world!"
        let record = testValue.record
        XCTAssertNotNil(record)
        XCTAssertEqual(try String(from: record!), testValue)
    }
}
