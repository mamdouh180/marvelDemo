

import Foundation

class CharacterComponent: Codable {
    var items: [CharacterComponentItems]
    
    init() {
        items = []
    }
}
