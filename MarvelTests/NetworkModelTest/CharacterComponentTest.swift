import XCTest
@testable import Marvel

class CharacterComponentTest: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testInit_defaultValues(){
        let characterComponent = CharacterComponent()
        XCTAssertNotNil(characterComponent)
        XCTAssertEqual(characterComponent.items.count, 0)
    }
    
}
