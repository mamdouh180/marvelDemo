

import UIKit

class CharacterDetailsViewController: UIViewController {

    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    var characterDetailsPresenter: CharacterDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //This causes crashes here so I configured it before opening the VC
        //characterDetailsPresenter = CharacterDetailsPresenter(characterdetailsView: self)
        initializeItems()
        characterDetailsPresenter.getCharacterComponentImages()
    }
    
    func initializeItems(){
        characterNameLabel.text = characterDetailsPresenter.name
        titleLabel.text = characterDetailsPresenter.name
        characterDescriptionLabel.text = characterDetailsPresenter.debugDescription
        characterImage.sd_setImage(with: URL(string: characterDetailsPresenter.image ), placeholderImage: UIImage(named: "img-placeholder"))
    }
    
    //MARK:- Actions
    @IBAction func onTapBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapDetails(_ sender: UITapGestureRecognizer) {
        characterDetailsPresenter.openDetailsLink()
    }
    
    @IBAction func onTapWiki(_ sender: UITapGestureRecognizer) {
        characterDetailsPresenter.openWikiLink()
    }
    
    @IBAction func onTapComic(_ sender: UITapGestureRecognizer) {
        characterDetailsPresenter.openComicLink()
    }
    

  
}


