
import Foundation
import Alamofire
import SwiftyJSON
import CommonCrypto

class NetworkInteractor{
    

    static let MarvelPublicKey = "2995c4463e93304b16605cec04aecb49",
    MarvelPrivateKey = "2645c1529b3c86457198917f42d063a2245059f8"
    
    static let baseEndPoit = "http://gateway.marvel.com/",
    characters = "v1/public/characters"
    
    
    //MARK:- Marvel Hashing
    static func md5(_ string: String) -> String {
        
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        //context.deallocate(capacity: 1)
        context.deallocate()
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        
        return hexString
    }
    
    static func getTs() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: date)
    }
    
    static func generateMarvelHash(ts: String) -> String{
        
        //ts+privateKey+publicKey
        return md5(ts+MarvelPrivateKey+MarvelPublicKey)
    }
    
    
    //MARK:- get Characters
    static func getCharacters(offset: Int, _ completion: @escaping (_ result: CharactersResponse) -> Void){
        
        let ts = getTs()
        let hash = generateMarvelHash(ts: ts)
        let link = "\(baseEndPoit)\(characters)?hash=\(hash)&ts=\(ts)&apikey=\(MarvelPublicKey)&offset=\(offset)"
        
        
        Alamofire.request(link, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    
                    
                    if let data = response.data{
                        if let model = try? JSONDecoder().decode(CharactersResponse.self, from: data){
                            if model.code! == 200{
                                model.success = true;
                                completion(model)
                            }else{
                                let emptyModel = CharactersResponse()
                                emptyModel.success = false
                                emptyModel.error = model.status
                                completion(emptyModel);
                            }
                        }
                    }
                case .failure:
                    let emptyModel = CharactersResponse()
                    emptyModel.success = false
                    emptyModel.error = response.result.error!.localizedDescription
                    completion(emptyModel);
                }
        }
    }
    
    //MARK:- get Characters
    static func searchCharacters(name: String, offset: Int, _ completion: @escaping (_ result: CharactersResponse) -> Void) -> DataRequest{
        
        let ts = getTs()
        let hash = generateMarvelHash(ts: ts)
        let link = "\(baseEndPoit)\(characters)?hash=\(hash)&ts=\(ts)&apikey=\(MarvelPublicKey)&nameStartsWith=\(name)&offset=\(offset)"
        
        
        return Alamofire.request(link, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    
                    if let data = response.data{
                        if let model = try? JSONDecoder().decode(CharactersResponse.self, from: data){
                            if model.code! == 200{
                                model.success = true;
                                completion(model)
                            }else{
                                let emptyModel = CharactersResponse()
                                emptyModel.success = false
                                emptyModel.error = model.status
                                completion(emptyModel);
                            }
                        }
                    }
                case .failure:
                    let emptyModel = CharactersResponse()
                    emptyModel.success = false
                    emptyModel.error = response.result.error!.localizedDescription
                    completion(emptyModel);
                }
        }
        
    }
    
    //MARK:- get Characters
    static func getCharacterComponent(resourceURI: String, index: Int, type: ComponentType ,_ completion: @escaping (_ result: ComponentResponse, _ passedIndex: Int, _ passedType: ComponentType) -> Void){
        
        let ts = getTs()
        let hash = generateMarvelHash(ts: ts)
        let link = "\(resourceURI)?hash=\(hash)&ts=\(ts)&apikey=\(MarvelPublicKey)"
        
        
        Alamofire.request(link, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    
                    if let data = response.data{
                        if let model = try? JSONDecoder().decode(ComponentResponse.self, from: data){
                            if model.code! == 200{
                                model.success = true;
                                completion(model, index, type)
                            }else{
                                let emptyModel = ComponentResponse()
                                emptyModel.success = false
                                emptyModel.error = model.status
                                completion(emptyModel, index, type);
                            }
                        }
                    }
                case .failure:
                    let emptyModel = ComponentResponse()
                    emptyModel.success = false
                    emptyModel.error = response.result.error!.localizedDescription
                    completion(emptyModel, index, type);
                }
        }
    }
    
    
    //=========================================================================
    
    
    //Important exaple how to use Codable
    /*static func getHomeData(_ counter: Int ,completion: @escaping (_ result: JSON ) -> Void){
    
        print("zzzzzzzzzzzz.......calling= \(counter)")
        
        let parameters = [
            "token": "97c6219684897441647130ea5d867250b622e73f"
            ]
        
        Alamofire.request(API_URL+HOME , method: .post , parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                print("zzzzzzzzzzzz.......response counter= \(counter)")
                
                switch response.result {
                case .success:
                    switch response.response?.statusCode{
                    case 200:
                        print("Network success operation")
                        
                        //print("zzzzzzzzzzzz.....returned data= \(response.result.value!)")
                        
                        
                        if let model = try? JSONDecoder().decode(NotificationModel.self, from: response.data!){
                            
                            //print("zzzzzz....count=\(model.unseen_count!)...msg=\(model.msg!)....code=\(model.code!)...message=\(model.message!)")
                            
                            let notification = model.notifications[2]
                            //print("zzzzzzz....path=\(notification.attachment?.path)...mime=\(notification.attachment?.mime)")
                            
                        }
                        
                        
                        
                        
                        
                        completion(JSON(response.result.value!))
                        break
                    case 400:
                        let swiftyJsonObject = JSON(response.result.value!)
                        print("Network error: bad response .. \(swiftyJsonObject["msg"].stringValue)" )
                        completion(JSON.null)
                        break
                    default:
                        let swiftyJsonObject = JSON(response.result.value!)
                        print("Network error: undetermined error .. \(swiftyJsonObject["error"].stringValue) .. \(swiftyJsonObject["msg"].stringValue)" )
                        completion(JSON.null)
                        break
                    }
                    break
                case .failure:
                    print("Network error: failure .. \(String(describing: response.result.error?.localizedDescription))")
                    completion(JSON.null)
                    break
                }
        }
}*/
    
}


