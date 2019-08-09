

import Foundation

class ComponentData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Component]
}
