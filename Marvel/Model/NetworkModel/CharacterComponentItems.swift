

import Foundation

class CharacterComponentItems: Codable {
    var resourceURI: String?
    var name: String?
    
    init() {
        self.resourceURI = ""
        self.name = ""
    }
    
    //Not in API
    var thumbnail: Thumbnail?
}
