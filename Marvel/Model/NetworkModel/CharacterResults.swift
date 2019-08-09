
import Foundation

class CharacterResults: Codable {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?
    var comics: CharacterComponent?
    var series: CharacterComponent?
    var stories: CharacterComponent?
    var events: CharacterComponent?
    var urls: [Linking]
    
    init() {
        self.id = 0
        self.name = ""
        self.description = ""
        self.thumbnail = nil
        self.comics = nil
        self.series = nil
        self.stories = nil
        self.events = nil
        self.urls = []
    }
    
    
    
    
}
