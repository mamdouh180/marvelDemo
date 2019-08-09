


import Foundation
import UIKit
import SystemConfiguration

class Utls {
    
    static func getViewController(viewControllerId: String) -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        return storyboard.instantiateViewController(withIdentifier: viewControllerId)
    }
    
    static func openViewController(currentViewContoller: UIViewController, newViewContoller: UIViewController){
        currentViewContoller.present(newViewContoller
            , animated: true, completion: nil)
    }
    
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
}

