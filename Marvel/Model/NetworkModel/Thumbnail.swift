

import Foundation

class Thumbnail: Codable {
    var path: String?
    var extensions: String?
    
    enum CodingKeys: String, CodingKey{
        case extensions = "extension"
        case path
    }
    
    init() {
        self.path = ""
        self.extensions = ""
    }
    
    func getImage(imageSize: ImageSize) -> String{
        let imagepath = self.path ?? ""
        let imageExtension = self.extensions ?? ""
        return  imagepath + "/" + imageSize.rawValue + "." + imageExtension
        
    }
}

enum ImageSize: String {
    case portrait_small, portrait_medium, portrait_xlarge, portrait_fantastic, portrait_uncanny, portrait_incredible
    case standard_small,standard_medium,standard_large,standard_xlarge,standard_fantastic,standard_amazing
    case landscape_small,landscape_medium,landscape_large,landscape_xlarge,landscape_amazing,landscape_incredible
}
