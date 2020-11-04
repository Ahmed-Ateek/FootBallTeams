import Foundation

class RequestComponent {
    
    static let sharesInstance = RequestComponent()
    
    func headerComponent(_ component: [RequestHeader]) -> [String: String]{
        var header = [String: String]()
        for singleComponent in component {
            switch singleComponent {
                case .authorization:
                    header["X-Auth-Token"] = "fec4730274234fa8b41c7d25215718f6"
                   
                    
                    break
                case .content:
                    header["Accept"] = "application/json"
                    break
                case .platform:
                    header["device_type"] = "ios"
                    break
                case .lang:
                    header["lang"] = "en"
                    break
            case .uploading:
                header["Content-Type"] = "application/x-www-form-urlencoded"
            }
        }
        return header
    }
}
 
