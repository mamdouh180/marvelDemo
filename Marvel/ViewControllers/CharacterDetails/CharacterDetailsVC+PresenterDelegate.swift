

import Foundation
import UIKit

extension CharacterDetailsViewController: CharacterDetailsViewDelegate{
    func reloadComicsCollectionView(){
        comicsCollectionView.reloadData()
    }
    func reloadSeriesCollectionView(){
        seriesCollectionView.reloadData()
    }
    func reloadStoriesCollectionView(){
        storiesCollectionView.reloadData()
    }
    func reloadEventsCollectionView(){
        eventsCollectionView.reloadData()
    }
}
