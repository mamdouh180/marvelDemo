

import Foundation

class ComponentResponse: Codable {
    var code: Int?
    var status: String?
    var data: ComponentData?
    
    var success:Bool!
    var error:String?
}
