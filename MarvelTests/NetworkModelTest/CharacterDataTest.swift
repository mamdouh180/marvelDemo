

import XCTest
@testable import Marvel

class CharacterDataTest: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testInit_defaultValues(){
        let characterData = CharacterData()
        XCTAssertNotNil(characterData)
        XCTAssertEqual(characterData.offset, 0)
        XCTAssertEqual(characterData.limit, 20)
        XCTAssertEqual(characterData.total, 0)
        XCTAssertEqual(characterData.results.count,0)
    }
    
}
