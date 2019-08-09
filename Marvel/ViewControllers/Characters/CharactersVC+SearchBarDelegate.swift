
import UIKit
import Foundation

extension CharactersViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        characterPresenter.makeSearch(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.moreActicityIndicatorView.isHidden = true
        characterPresenter.changeSearchMode(isSearching:false)
        searchBar.isHidden = true
        charactersTableView.isHidden = false
        characterSearchTableView.isHidden = true
        moreActicityIndicatorView.isHidden = true
        characterPresenter.resetSearch()
        charactersTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
