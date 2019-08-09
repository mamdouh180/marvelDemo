

import XCTest
@testable import Marvel

class ComponentsTest: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testInit_defaultValues(){
        let components = Components()
        XCTAssertNotNil(components)
        XCTAssertEqual(components.characterId, 0)
        XCTAssertEqual(components.name, "")
        XCTAssertEqual(components.type, "")
        
    }
    
}
