

import Foundation
import UIKit

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource{
    
    enum CellHeight: CGFloat {
        case charactersCellHeight = 170
        case CharacterSearchCellHeight = 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterPresenter.getTableViewRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if characterPresenter.isInSearchMode(){
            let characterSearchCell = characterSearchTableView.dequeueReusableCell(withIdentifier: "CharacterSearchTableViewCell") as! CharacterSearchTableViewCell
            characterPresenter.configureSearchCharacterTableViewCell(characterSearchCell: characterSearchCell, indexPath: indexPath)
            return characterSearchCell
            
        }else{
            let charactersCell = charactersTableView.dequeueReusableCell(withIdentifier: "CharactersTableViewCell") as! CharactersTableViewCell
            characterPresenter.configureCharacterTableViewCell(charactersCell: charactersCell, indexPath: indexPath)
            charactersCell.characterName.setLeftPaddingPoints(textPadding)
            charactersCell.characterName.setRightPaddingPoints(textPadding)
            return charactersCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return characterPresenter.isInSearchMode() ? CellHeight.CharacterSearchCellHeight.rawValue : CellHeight.charactersCellHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsViewController =  Utls.getViewController(viewControllerId: "CharacterDetailsViewController") as! CharacterDetailsViewController
        
        //---------------
        characterDetailsViewController.characterDetailsPresenter = CharacterDetailsPresenter(characterdetailsView: characterDetailsViewController)
        //---------------
        
        characterDetailsViewController.characterDetailsPresenter.character /*character*/ = (tableView == charactersTableView) ? characterPresenter.getCharacter(row:indexPath.row) : characterPresenter.getSearchCharacter(row:indexPath.row)
        Utls.openViewController(currentViewContoller: self, newViewContoller: characterDetailsViewController)
    }
    
    
}
