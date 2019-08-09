import Foundation
import RealmSwift

class Characters: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var imagePath = ""
    @objc dynamic var imageExtension = ""

    var components = List<Components>()

}
