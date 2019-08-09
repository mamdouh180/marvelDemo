

import UIKit
import ImageSlideshow
import SDWebImage

class ImageSliderViewController: UIViewController {
    
    var imagesArray = [InputSource]()
    var startImageIndex: Int = 0

    var passedImagesArray = [CharacterComponentItems]()
    @IBOutlet weak var sliderView: ImageSlideshow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pageCounterLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageSlider()
    }
    
    //MARK: - Image Slider
    func configureImageSlider(){
        
        for itemObject in passedImagesArray{
            
            let imageToLoad = itemObject.thumbnail?.getImage(imageSize: ImageSize.portrait_incredible) ?? ""
            let placeholder = "img-placeholder"
            
            if let image = SDWebImageSource(urlString:imageToLoad,placeholder:UIImage(named: placeholder)){
                imagesArray.append(image)
            }else{
                imagesArray.append(ImageSource(image: UIImage(named: placeholder)!))
            }
            
        }
        
        sliderView.setImageInputs(imagesArray)
        sliderView.zoomEnabled = true
        sliderView.circular = false
        sliderView.pageControlPosition = PageControlPosition.hidden  //I left warning because I want to hide page position to match required design
        
        //Open slider on specific image
        sliderView.setCurrentPage(startImageIndex, animated: false)
        
        self.setImageSliderPageNumber(page: startImageIndex)
        
        sliderView.currentPageChanged = {
            (_ page: Int) -> () in
            self.setImageSliderPageNumber(page: page)
        }
        
        //To get the current page
        //sliderView.currentPage
    }
    
    func setImageSliderPageNumber(page: Int){
        pageCounterLabel.text = String(page+1)+"/"+String(imagesArray.count)
    }
    
    //MARK:- Actions
    @IBAction func onTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
