
import UIKit
import Foundation

extension CharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comicsCollectionView{
            return characterDetailsPresenter.getComicsCount()
        }else if collectionView == seriesCollectionView{
            return characterDetailsPresenter.getSeriesCount()
        }else if collectionView == storiesCollectionView{
            return characterDetailsPresenter.getStoriesCount()
        }else {
            return characterDetailsPresenter.getEventsCount()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == comicsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicsCollectionViewCell", for: indexPath) as! ComicsCollectionViewCell
            characterDetailsPresenter.configureComicsCollectionViewCell(cell: cell, indexPath: indexPath)
            return cell
        }else if collectionView == seriesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCollectionViewCell", for: indexPath) as! SeriesCollectionViewCell
            characterDetailsPresenter.configureSeriesCollectionViewCell(cell: cell, indexPath: indexPath)
            return cell
        }else if collectionView == storiesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCollectionViewCell", for: indexPath) as! StoriesCollectionViewCell
            characterDetailsPresenter.configureStoriesCollectionViewCell(cell: cell, indexPath: indexPath)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionViewCell", for: indexPath) as! EventsCollectionViewCell
            characterDetailsPresenter.configureEventsCollectionViewCell(cell: cell, indexPath: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let cellHeight = collectionView.frame.height, cellWidth = CGFloat(130
        )
        
        return  CGSize(width: cellWidth, height: cellHeight)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageSliderViewController =  Utls.getViewController(viewControllerId: "ImageSliderViewController") as! ImageSliderViewController
        if collectionView == comicsCollectionView{
            imageSliderViewController.passedImagesArray = characterDetailsPresenter.getComicsItems()
        }else if collectionView == seriesCollectionView{
            imageSliderViewController.passedImagesArray = characterDetailsPresenter.getSeriesItems()
        }else if collectionView == storiesCollectionView{
            imageSliderViewController.passedImagesArray = characterDetailsPresenter.getStoriesItems()
        }else{
            imageSliderViewController.passedImagesArray = characterDetailsPresenter.getEventsItems()
        }
        imageSliderViewController.startImageIndex = indexPath.row
        Utls.openViewController(currentViewContoller: self, newViewContoller: imageSliderViewController)
    }
}
