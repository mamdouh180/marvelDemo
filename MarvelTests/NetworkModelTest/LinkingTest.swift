import XCTest
@testable import Marvel

class LinkingTest: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testInit_defaultValues(){
        let linking = Linking()
        XCTAssertNotNil(linking)
        XCTAssertEqual(linking.type, "")
        XCTAssertEqual(linking.url, "")
    }
    
}
