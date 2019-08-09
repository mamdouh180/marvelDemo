import XCTest
@testable import Marvel

class CharacterComponentItemsTest: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testInit_defaultValues(){
        let characterComponentItems = CharacterComponentItems()
        XCTAssertNotNil(characterComponentItems)
        XCTAssertEqual(characterComponentItems.resourceURI, "")
        XCTAssertEqual(characterComponentItems.name, "")
    }
    
}
