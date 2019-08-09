
import Foundation

import Foundation
import RealmSwift

class DatabaseInteractor: NSObject {
    static let shared = DatabaseInteractor()
    
    func insertCharacters(characterModel: CharacterData){
        
        insertComponents(characterModel: characterModel)
        
        deleteAllCharacters()
        
        let realm = try! Realm()
        for item in characterModel.results{
            let character = Characters()
            character.id = item.id ?? 0
            character.name = item.name ?? ""
            character.desc = item.description ?? ""
            character.imagePath = item.thumbnail?.path ?? ""
            character.imageExtension = item.thumbnail?.extensions ?? ""
            let characterComponents = getCharacterComponents(id: item.id!)
            for component in characterComponents{
                character.components.append(component)
            }
            try! realm.write {
                realm.add(character)
            }
        }
    }
    
    func insertComponents(characterModel: CharacterData){
        
        deleteAllComponents()
        
        for character in characterModel.results{
            let comics = character.comics?.items
            insertComponentSet(items: comics!, characterId: character.id!, type:ComponentType.Comics)
            
            let series = character.series?.items
            insertComponentSet(items: series!, characterId: character.id!, type:ComponentType.Series)
            
            let stories = character.stories?.items
            insertComponentSet(items: stories!, characterId: character.id!, type:ComponentType.Stories)
            
            let events = character.events?.items
            insertComponentSet(items: events!, characterId: character.id!, type:ComponentType.Events)
        }
    }
    
    func insertComponentSet(items: [CharacterComponentItems], characterId: Int, type: ComponentType){
        let realm = try! Realm()
        for item in items{
            let component = Components()
            component.name = item.name ?? ""
            component.characterId = characterId
            component.type = type.rawValue
            try! realm.write {
                realm.add(component)
            }
        }
    }
    
    
    func getCharacterComponents(id: Int) -> Results<Components> {
        let ralm = try! Realm()
        let predicate = "characterId=\(id)"
        let components = ralm.objects(Components.self).filter(predicate)
        return components
    }
    
    func deleteAllComponents(){
        let realm = try! Realm()
        let components = realm.objects(Components.self)
        for component in components{
            try! realm.write {
                realm.delete(component)
            }
        }
    }
    
    func deleteAllCharacters(){
        let realm = try! Realm()
        let characters = realm.objects(Characters.self)
        for character in characters{
            try! realm.write {
                realm.delete(character)
            }
        }
    }
    
    func getcharacters() -> CharactersResponse {
        let realm = try! Realm()
        let characters = realm.objects(Characters.self)
        
        let characterResponse = CharactersResponse()
        let characterData = CharacterData()
        
        for dbCharacter in characters{
            
            let thumbnail = Thumbnail()
            thumbnail.path = dbCharacter.imagePath
            thumbnail.extensions = dbCharacter.imageExtension
            
            let comics = CharacterComponent()
            let series = CharacterComponent()
            let stories = CharacterComponent()
            let events = CharacterComponent()
            
            for comp in dbCharacter.components{
                let characterComponentItems = CharacterComponentItems()
                characterComponentItems.name = comp.name
                
                switch comp.type{
                case ComponentType.Comics.rawValue:
                        comics.items.append(characterComponentItems)
                case ComponentType.Series.rawValue:
                    series.items.append(characterComponentItems)
                case ComponentType.Stories.rawValue:
                    stories.items.append(characterComponentItems)
                case ComponentType.Events.rawValue:
                    events.items.append(characterComponentItems)
                default:
                    print("")
                }
            }
            
            let characterResults = CharacterResults()
            characterResults.id = dbCharacter.id
            characterResults.name = dbCharacter.name
            characterResults.description = dbCharacter.desc
            characterResults.thumbnail = thumbnail
            characterResults.comics = comics
            characterResults.series = series
            characterResults.stories = stories
            characterResults.events = events
            
            
            characterData.results.append(characterResults)
        }
        
        characterResponse.data = characterData
        
        return characterResponse
    
    }
    
}
