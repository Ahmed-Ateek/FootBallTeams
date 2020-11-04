import Foundation
import Alamofire
//VC Identifiers
let Get_Car_List = "GetCarListVC"
let Select_Booking_Details_VC = "SelectBookingDetailsVC"
//tyealias
typealias CompletionHandler<T:Decodable> = (_ error:String?,_ code:Int?,T?)->()
typealias CompletionHandlerB = (_ success:Bool?)->()
typealias CompletionHandlerString = (_ VC:UIViewController?)->()
//check internet
struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
struct GETUDID {
     static let sharesInstance = GETUDID()
    var udid =  UIDevice.current.identifierForVendor?.uuidString ?? "" 
  
}


//let Get_Policy_URL = "\(BASE_URL)get_policy"
//let Get_terms_URL = "\(BASE_URL)get_terms"
//let Get_DATE_UPCOMING_BOOKING =  "\(BASE_URL)get_my_date_upcoming_booking"
//let Get_UPCOMING_BOOKING = "\(BASE_URL)list_booking_upcoming"
//let Get_History_Booking = "\(BASE_URL)list_booking_history"
//let GET_Date_History_booking = "\(BASE_URL)get_my_date_history_booking"
//let GET_Booking_Details = "\(BASE_URL)booking_details"
//let GET_Cancel_booking = "\(BASE_URL)cancel_reason"
//let Send_Cancel_Booking = "\(BASE_URL)cancel_booking_by_client"
//
//// testing fork 
let Base_URL  = "http://api.football-data.org/v2"
let Get_Teams_API = Base_URL+"/competitions/2000/teams"
