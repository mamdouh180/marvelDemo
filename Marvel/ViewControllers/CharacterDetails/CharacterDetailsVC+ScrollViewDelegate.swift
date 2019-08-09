
import UIKit
import Foundation

extension CharacterDetailsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageHeight = characterImage.bounds.size.height
        let boundary = imageHeight - 100
        let offset = scrollView.contentOffset.y
        if offset > boundary {
            var requiredAlpha = (1.0 - (imageHeight - offset)/100.0)
            requiredAlpha = requiredAlpha > 0.6 ? 0.6 : requiredAlpha
            topBarView.alpha = requiredAlpha
        }else{
            topBarView.alpha = 0.0
        }
    }
}
