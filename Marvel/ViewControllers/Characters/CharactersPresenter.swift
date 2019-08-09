

import Foundation
import Alamofire
import UIKit

protocol CharactersViewDelegate: class {
    func changeActivityIndicatorVisibility(makeInvisible: Bool)
    func changemoreActicityIndicatorViewVisibility(makeInvisible: Bool)
    func reloadCharactersTableView()
    func reloadCharactersSearchTableView()
    func handlegetCharactersNetworkUIItems()
    func getSearchTest() -> String
}

class CharactersPresenter {
    private weak var charactersViewDelegate: CharactersViewDelegate?
    var characterCount = 0, searchCharacterCount = 0
    var isSearchMode = false
    var isCharacterLoading = false, isCharacterSearchLoading = false
    
    var character = CharactersResponse()
    var characterSearch = CharactersResponse()
    
    var result = CharacterResults()
    
    var searchRequest: DataRequest?
    
    init(charactersView: CharactersViewDelegate) {
        charactersViewDelegate = charactersView
    }
    
    
    //MARK:- Offline data
    func loadOfflineData(){
        character = DatabaseInteractor.shared.getcharacters()
        charactersViewDelegate?.reloadCharactersTableView()
    }
    
    
    //MARK:- Search Configuration
    func changeSearchMode(isSearching: Bool){
        isSearchMode = isSearching
    }
    
    func isInSearchMode() -> Bool{
        return isSearchMode
    }
    
    func resetSearch(){
        characterSearch = CharactersResponse()
    }
    
    func makeSearch(searchText: String){
        if searchText == ""{
            resetSearch()
            charactersViewDelegate?.reloadCharactersSearchTableView()
            return
        }
        if let searchRequest = searchRequest{
            searchRequest.cancel()
        }
        searchCharacters(name: searchText, offset: 0)
    }
    
    //MARK:- Pagination
    func changeCharacterCount(count: Int){
        characterCount = count
    }
    
    func changeSearchCharacterCount(count: Int){
        searchCharacterCount = count
    }
    
    
    func changeCharacterLoadingStatus(isLoading: Bool ){
        isCharacterLoading = isLoading
    }
    
    func changeSearchCharacterLoadingStatus(isLoading: Bool ){
        isCharacterSearchLoading = isLoading
    }
    
    func loadMoreData(){
        if isSearchMode {
            if !isCharacterSearchLoading && (characterSearch.data?.results.count != (characterSearch.data?.total)! ){
                changeSearchCharacterLoadingStatus(isLoading: true)
                searchCharacters(name: charactersViewDelegate?.getSearchTest() ?? "", offset: getNextOffset())
                charactersViewDelegate?.changemoreActicityIndicatorViewVisibility(makeInvisible: false)
            }
        }else{
            if !isCharacterLoading && (character.data?.results.count != (character.data?.total)!) {
                changeSearchCharacterLoadingStatus(isLoading:true)
                charactersViewDelegate?.changemoreActicityIndicatorViewVisibility(makeInvisible: false)
                getCharacters(offset: getNextOffset())
            }
        }
    }
    
    func updateLoadingCount(){
        if isSearchMode{
            searchCharacterCount+=1
        }else{
            characterCount+=1
        }
    }
    
    func getNextOffset() -> Int{
        if isSearchMode{
            return searchCharacterCount * (characterSearch.data?.limit)!
        }else{
            return characterCount * (character.data?.limit)!
        }
    }
    
    //MARK:- Loading Data
    func loadFirstTimeCharacters(){
        if Utls.isConnectedToNetwork(){
            charactersViewDelegate?.changeActivityIndicatorVisibility(makeInvisible: false)
            getCharacters(offset: 0)
        }else{
            loadOfflineData()
        }
    }
    
    func loadPullToRefreshCharacters(){
        changeCharacterCount(count: 0)
        getCharacters(offset: 0)
    }
    
    //MARK:- Networking
    func getCharacters(offset: Int){
        if !Utls.isConnectedToNetwork(){
            changeCharacterLoadingStatus(isLoading: false)
            charactersViewDelegate?.handlegetCharactersNetworkUIItems()
            return
        }
        NetworkInteractor.getCharacters(offset: offset) { (response) in
            self.changeCharacterLoadingStatus(isLoading: false)
            self.charactersViewDelegate?.handlegetCharactersNetworkUIItems()
            if response.success{
                if (offset==0){
                    self.characterCount = 0
                    self.character = response
                    if let characterData = response.data{
                        DispatchQueue.global(qos: .default).async {
                            DatabaseInteractor.shared.insertCharacters(characterModel: characterData)
                        }
                    }
                }else{
                    self.updateCharacter(currentCharacter:self.character,newCharacter: response)
                }
                self.updateLoadingCount()
                self.charactersViewDelegate?.reloadCharactersTableView()
            }else{
                print(response.error!)
            }
        }
    }
    
    func searchCharacters(name: String, offset: Int){
        if !Utls.isConnectedToNetwork(){
            self.changeSearchCharacterLoadingStatus(isLoading: false)
            charactersViewDelegate?.changemoreActicityIndicatorViewVisibility(makeInvisible: true)
            return
        }
        searchRequest = NetworkInteractor.searchCharacters(name: name, offset: offset) { (response) in
            self.changeSearchCharacterLoadingStatus(isLoading: false)
            self.charactersViewDelegate?.changemoreActicityIndicatorViewVisibility(makeInvisible: true)
            if response.success{
                if (offset==0){
                    self.characterSearch = response
                }else{
                    self.updateCharacter(currentCharacter:self.characterSearch,newCharacter: response)
                }
                self.updateLoadingCount()
                self.charactersViewDelegate?.reloadCharactersSearchTableView()
            }else{
                print(response.error!)
            }
        }
    }
    
    func updateCharacter(currentCharacter: CharactersResponse, newCharacter: CharactersResponse){
        currentCharacter.code = newCharacter.code
        currentCharacter.status = newCharacter.status
        currentCharacter.data?.offset = newCharacter.data?.offset
        currentCharacter.data?.limit = newCharacter.data?.limit
        currentCharacter.data?.total = newCharacter.data?.total
        currentCharacter.data?.count = newCharacter.data?.count
        if let results = newCharacter.data?.results{
            currentCharacter.data?.results += results
        }
    }
    
    
    //MARK:- TableView data
    func getTableViewRowsCount() -> Int{
       return isSearchMode ? (characterSearch.data?.results.count ?? 0) :(character.data?.results.count ?? 0)
    }
    
    func configureCharacterTableViewCell(charactersCell: CharactersTableViewCell, indexPath: IndexPath){
        let characterObject = character.data?.results[indexPath.row]
        charactersCell.characterName.text = characterObject?.name ?? ""
        charactersCell.characterImage.sd_setImage(with: URL(string: characterObject?.thumbnail?.getImage(imageSize: ImageSize.landscape_amazing) ?? "" ), placeholderImage: UIImage(named: "img-placeholder"))
        
        //Cache image with different size to be used character in details scren
        if indexPath.row < character.data?.limit ?? 20{
            let img = UIImageView()
            img.sd_setImage(with: URL(string: characterObject?.thumbnail?.getImage(imageSize: ImageSize.standard_fantastic) ?? "" ), placeholderImage: UIImage(named: "img-placeholder"))
        }
        
        if indexPath.row == (character.data?.results.count)! - 1{
            loadMoreData()
        }
    }
    
    func configureSearchCharacterTableViewCell(characterSearchCell: CharacterSearchTableViewCell,  indexPath: IndexPath){
        let characterSearchObject = characterSearch.data?.results[indexPath.row]
        characterSearchCell.characterSearchName.text = characterSearchObject?.name ?? ""
        characterSearchCell.characterSearchImage.sd_setImage(with: URL(string: characterSearchObject?.thumbnail?.getImage(imageSize: ImageSize.standard_large) ?? "" ), placeholderImage: UIImage(named: "Rooms_home_img"))
        
        if indexPath.row == (characterSearch.data?.results.count)! - 1{
            loadMoreData()
        }
    }
    
    //MARK:- Transition
    func getCharacter(row:Int) -> CharacterResults{
        return (character.data?.results[row])!
    }
    
    func getSearchCharacter(row:Int)  -> CharacterResults{
        return (characterSearch.data?.results[row])!
    }
    
}
