
import Foundation

extension CharactersViewController: CharactersViewDelegate{
    
    func changeActivityIndicatorVisibility(makeInvisible: Bool){
        loadingAcivityIndicator.isHidden = makeInvisible
    }
    
    func reloadCharactersTableView(){
        charactersTableView.reloadData()
    }
    
    func reloadCharactersSearchTableView(){
        characterSearchTableView.reloadData()
    }
    
    func getSearchTest() -> String{
        return searchBar.text!
    }
    
    func changemoreActicityIndicatorViewVisibility(makeInvisible: Bool){
        moreActicityIndicatorView.isHidden = makeInvisible
    }
    
    //MARK:- Network helper functions
    func handlegetCharactersNetworkUIItems(){
        self.charactersRefreshControl.endRefreshing()
        self.loadingAcivityIndicator.isHidden = true
        self.moreActicityIndicatorView.isHidden = true
    }
    

}
