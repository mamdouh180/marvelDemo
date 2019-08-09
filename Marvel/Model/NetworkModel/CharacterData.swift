

import Foundation

class CharacterData: Codable {
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [CharacterResults]
    
    init() {
        self.offset = 0
        self.limit = 20
        self.total = 0
        self.count = 0
        self.results = []
    }
}
