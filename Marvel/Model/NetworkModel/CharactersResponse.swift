

import Foundation

class CharactersResponse: Codable {
    
    var code: Int?
    var status: String?
    var data: CharacterData?
    
    var success:Bool!
    var error:String?
    
    
}
