

import XCTest
@testable import Marvel

class CharactersVC_PresenterDelegateTest: XCTestCase {
    
    var charactersVC: CharactersViewController!
    
    override func setUp() {
        charactersVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharactersViewController") as? CharactersViewController
        _ = charactersVC.view
    }
    
    override func tearDown() {
        
    }
    
    func testLoadingAcivityIndicator_willBeHidden(){
        charactersVC.loadingAcivityIndicator.isHidden = true
        let visibilityStatus1 = charactersVC.loadingAcivityIndicator.isHidden
        charactersVC.changeActivityIndicatorVisibility(makeInvisible: true)
        let visibilityStatus2 = charactersVC.loadingAcivityIndicator.isHidden
        XCTAssertEqual(visibilityStatus1 ,visibilityStatus2)
    }
    
    func testSearchBarText_returnText(){
        charactersVC.searchBar.text = "Text"
        XCTAssertEqual("Text" ,charactersVC.getSearchTest())
    }
    
    func testMoreActicityIndicatorViewVisibility_willBeHidden(){
        charactersVC.moreActicityIndicatorView.isHidden = true
        let visibilityStatus1 = charactersVC.moreActicityIndicatorView.isHidden
        charactersVC.changemoreActicityIndicatorViewVisibility(makeInvisible: true)
        let visibilityStatus2 = charactersVC.moreActicityIndicatorView.isHidden
        XCTAssertEqual(visibilityStatus1 ,visibilityStatus2)
    }
    
    func testHandlegetCharactersNetworkUIItems(){
        testLoadingAcivityIndicator_willBeHidden()
        testMoreActicityIndicatorViewVisibility_willBeHidden()
        charactersVC.charactersRefreshControl.endRefreshing()
        XCTAssertFalse(charactersVC.charactersRefreshControl.isRefreshing)
    }

}
