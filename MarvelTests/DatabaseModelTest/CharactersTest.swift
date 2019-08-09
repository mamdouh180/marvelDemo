

import XCTest
@testable import Marvel

class CharactersTest: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testInit_defaultValues(){
        let characters = Characters()
        XCTAssertNotNil(characters)
        XCTAssertEqual(characters.id, 0)
        XCTAssertEqual(characters.name, "")
        XCTAssertEqual(characters.desc, "")
        XCTAssertEqual(characters.imagePath, "")
        XCTAssertEqual(characters.imageExtension, "")
        XCTAssertEqual(characters.components.count, 0)

    }
    
}
