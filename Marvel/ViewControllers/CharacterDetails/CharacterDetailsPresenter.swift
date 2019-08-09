
import UIKit
import Foundation

protocol CharacterDetailsViewDelegate: class {
    func reloadComicsCollectionView()
    func reloadSeriesCollectionView()
    func reloadStoriesCollectionView()
    func reloadEventsCollectionView()
}

class CharacterDetailsPresenter {
    private weak var characterDetailsViewDelegate: CharacterDetailsViewDelegate?
    var character: CharacterResults!
    
    var name: String {return character.name ?? ""}
    var description: String {return character.description ?? ""}
    var image: String {return character.thumbnail?.getImage(imageSize: ImageSize.standard_fantastic) ?? ""}

    init(characterdetailsView: CharacterDetailsViewDelegate) {
        characterDetailsViewDelegate = characterdetailsView
    }
    
    func openDetailsLink(){
        openUrl(link: character.urls[0].url)
    }
    
    func openWikiLink(){
        openUrl(link: character.urls[1].url)
    }
    
    func openComicLink(){
        openUrl(link: character.urls[2].url)
    }
    
    func openUrl(link: String){
        guard let url = URL(string: link) else { return }
        //UIApplication.shared.openURL(url)
        UIApplication.shared.open(url, completionHandler: nil)
    }
    
    //MARK:- Networking
    func getCharacterComponentImages(){
        let comicsCount = character.comics?.items.count ?? 0
        let seriesCount = character.series?.items.count ?? 0
        let storiesCount = character.stories?.items.count ?? 0
        let eventsCount = character.events?.items.count ?? 0
        
        
        getCharacterComponent(type: ComponentType.Comics, count: comicsCount)
        getCharacterComponent(type: ComponentType.Series, count: seriesCount)
        getCharacterComponent(type: ComponentType.Stories, count: storiesCount)
        getCharacterComponent(type: ComponentType.Events, count: eventsCount)
        
    }
    
    func getCharacterComponent(type: ComponentType, count: Int){
        var resourceURI: String!
        for index in 0..<count{
            
            switch type{
            case .Comics:
                resourceURI = character.comics?.items[index].resourceURI ?? ""
            case .Series:
                resourceURI = character.series?.items[index].resourceURI  ?? ""
            case .Stories:
                resourceURI = character.stories?.items[index].resourceURI  ?? ""
            case .Events:
                resourceURI = character.events?.items[index].resourceURI  ?? ""
            }
            
            
            NetworkInteractor.getCharacterComponent(resourceURI: resourceURI, index: index, type: type) { (response, passedIndex, passedType) in
                if response.success{
                    
                    switch passedType{
                    case .Comics:
                        self.character.comics?.items[passedIndex].thumbnail = response.data?.results[0].thumbnail
                        self.characterDetailsViewDelegate?.reloadComicsCollectionView()
                        
                    case .Series:
                        self.character.series?.items[passedIndex].thumbnail = response.data?.results[0].thumbnail
                        self.characterDetailsViewDelegate?.reloadSeriesCollectionView()
                    case .Stories:
                        self.character.stories?.items[passedIndex].thumbnail = response.data?.results[0].thumbnail
                        self.characterDetailsViewDelegate?.reloadStoriesCollectionView()
                    case .Events:
                        self.character.events?.items[passedIndex].thumbnail = response.data?.results[0].thumbnail
                        self.characterDetailsViewDelegate?.reloadEventsCollectionView()
                    }
                    
                }else{
                    print(response.error!)
                }
            }
            
        }
    }
    
    //MARK:- CollectionViews functions
    func getComicsCount() -> Int{
        return character.comics?.items.count ?? 0
    }
    
    func getSeriesCount() -> Int{
        return character.series?.items.count ?? 0
    }
    
    func getStoriesCount() -> Int{
        return character.stories?.items.count ?? 0
    }
    
    func getEventsCount() -> Int{
        return character.events?.items.count ?? 0
    }
    
    func configureComicsCollectionViewCell(cell: ComicsCollectionViewCell, indexPath: IndexPath){
        cell.comicsName.text = character.comics?.items[indexPath.row].name ?? ""
        cell.comicsImage.sd_setImage(with: URL(string: character.comics?.items[indexPath.row].thumbnail?.getImage(imageSize: ImageSize.portrait_medium) ?? "" ), placeholderImage: UIImage(named: "img-placeholder"))
    }
    
    func configureSeriesCollectionViewCell(cell: SeriesCollectionViewCell, indexPath: IndexPath){
        cell.seriesName.text = character.series?.items[indexPath.row].name ?? ""
        cell.seriesImage.sd_setImage(with: URL(string: character.series?.items[indexPath.row].thumbnail?.getImage(imageSize: ImageSize.portrait_medium) ?? "" ), placeholderImage: UIImage(named: "img-placeholder"))
    }
    
    func configureStoriesCollectionViewCell(cell: StoriesCollectionViewCell, indexPath: IndexPath){
        cell.storiesName.text = character.stories?.items[indexPath.row].name ?? ""
        cell.storiesImage.sd_setImage(with: URL(string: character.stories?.items[indexPath.row].thumbnail?.getImage(imageSize: ImageSize.portrait_medium) ?? "" ), placeholderImage: UIImage(named: "img-placeholder"))
    }
    
    func configureEventsCollectionViewCell(cell: EventsCollectionViewCell, indexPath: IndexPath){
        cell.eventsName.text = character.events?.items[indexPath.row].name ?? ""
        cell.eventsImage.sd_setImage(with: URL(string: character.events?.items[indexPath.row].thumbnail?.getImage(imageSize: ImageSize.portrait_medium) ?? "" ), placeholderImage: UIImage(named: "img-placeholder"))
    }
    
    //MARK:- Transition
    func getComicsItems() -> [CharacterComponentItems]{
       return (character.comics?.items)!
    }
    
    func getSeriesItems() -> [CharacterComponentItems]{
        return (character.series?.items)!
    }
    
    func getStoriesItems() -> [CharacterComponentItems]{
        return (character.stories?.items)!
    }
    
    func getEventsItems() -> [CharacterComponentItems]{
        return (character.events?.items)!
    }
}
