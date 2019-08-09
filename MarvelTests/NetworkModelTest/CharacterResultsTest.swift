
import XCTest
@testable import Marvel

class CharacterResultsTest: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testInit_defaultValues(){
        let characterResults = CharacterResults()
        XCTAssertNotNil(characterResults)
        XCTAssertEqual(characterResults.id, 0)
        XCTAssertEqual(characterResults.name, "")
        XCTAssertEqual(characterResults.description, "")
        XCTAssertEqual(characterResults.urls.count, 0)
        XCTAssertNil(characterResults.thumbnail)
        XCTAssertNil(characterResults.comics)
        XCTAssertNil(characterResults.series)
        XCTAssertNil(characterResults.stories)
        XCTAssertNil(characterResults.events)
    }
    
}
