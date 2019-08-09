

import XCTest
@testable import Marvel

class DatabaseInteractorTest: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testSinglton_returnTrueForsingletonPattern(){
        let  databaseInteractor1 = DatabaseInteractor.shared
        let  databaseInteractor2 = DatabaseInteractor.shared
        XCTAssertEqual(databaseInteractor1, databaseInteractor2)
    }
    
    func testGetCharacterByIdAndComponents_returnsTrueIfCharacterExist(){
        let characterResponse = DatabaseInteractor.shared.getcharacters()
        if (characterResponse.data?.results.count)! > 0{
            let characterId = (characterResponse.data?.results[0].id)!
            let componnent = DatabaseInteractor.shared.getCharacterComponents(id: characterId)
            XCTAssertGreaterThanOrEqual(componnent.count, 1)
        }
        
    }
    
}
