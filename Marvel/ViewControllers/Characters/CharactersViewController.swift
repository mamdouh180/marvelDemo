

import UIKit
import SDWebImage

class CharactersViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButtton: UIButton!
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var characterSearchTableView: UITableView!
    @IBOutlet weak var moreActicityIndicatorView: UIView!
    @IBOutlet weak var loadingAcivityIndicator: UIActivityIndicatorView!
    
    var characterPresenter: CharactersPresenter!
    let textPadding: CGFloat = 10
    
    var charactersRefreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterPresenter = CharactersPresenter(charactersView: self)
        initializeItems()
        characterPresenter.loadFirstTimeCharacters()
    }
    
    
    //MARK:- Items initialization
    func initializeItems(){
        searchBar.delegate = self
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        configurePullToRefresh()
    }
    
    //MARK:- pull to refresh
   func configurePullToRefresh(){
        charactersRefreshControl = UIRefreshControl()
        charactersRefreshControl.attributedTitle = NSAttributedString(string: "")
        charactersRefreshControl.addTarget(self, action: #selector(CharactersViewController.refreshCharcters(_:)), for: UIControl.Event.valueChanged)
        charactersTableView.addSubview(charactersRefreshControl)
    }

    @objc func refreshCharcters(_ sender:AnyObject){
        self.moreActicityIndicatorView.isHidden = true
        characterPresenter.loadPullToRefreshCharacters()
    }
    
    //MARK:- Actions
    @IBAction func onTapSearch(_ sender: UIButton) {
        self.moreActicityIndicatorView.isHidden = true
        characterPresenter.changeSearchCharacterCount(count: 0)
        searchBar.isHidden = false
        searchBar.becomeFirstResponder()
        searchBar.text = ""
        moreActicityIndicatorView.isHidden = true
        characterPresenter.changeSearchMode(isSearching: true)
        characterSearchTableView.isHidden = false
        charactersTableView.isHidden = true
        characterSearchTableView.reloadData()
    }
    
    
}

