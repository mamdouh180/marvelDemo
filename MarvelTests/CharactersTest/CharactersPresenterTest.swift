
import XCTest
@testable import Marvel

class CharactersPresenterTest: XCTestCase {
    
    var characterVC: CharactersViewController!
    var presenter: CharactersPresenter!
    
    override func setUp() {
        characterVC = CharactersViewController()
        presenter = CharactersPresenter(charactersView: characterVC)
    }
    
    override func tearDown() {
        
    }
    
    func testSearchingMode(){
        presenter.changeSearchMode(isSearching: true)
        XCTAssertEqual(presenter.isInSearchMode(), true)
    }
    
    func testResetSearch(){
        presenter.resetSearch()
        XCTAssertNil(presenter.characterSearch.data)
    }
    
    func testChangeCharacterCount(){
        presenter.changeCharacterCount(count: 5)
        XCTAssertEqual(presenter.characterCount, 5)
    }
    
    func testChangeSearchCharacterCount(){
        presenter.changeSearchCharacterCount(count: 5)
        XCTAssertEqual(presenter.searchCharacterCount, 5)
    }
    
    func testChangeCharacterLoadingStatus(){
        presenter.changeCharacterLoadingStatus(isLoading: true)
        XCTAssertEqual(presenter.isCharacterLoading, true)
    }
    
    func testChangeSearchCharacterLoadingStatus(){
        presenter.changeSearchCharacterLoadingStatus(isLoading: true)
        XCTAssertEqual(presenter.isCharacterSearchLoading, true)
    }
    
    
    
}
