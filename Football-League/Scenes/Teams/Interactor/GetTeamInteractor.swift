//
//  GetTeamInteractor.swift
//  Football-League
//
//  Created by Tk on 03/11/2020.
//

import Foundation
// here to func to get only teams
class GetTeamInteractor {
    
    func getTeams(completion:@escaping CompletionHandler<TeamsModel> ){
        let heards = RequestComponent.sharesInstance.headerComponent([.content,.authorization])
        RequestManager.sharesInstance.request(fromUrl: Get_Teams_API, byMethod: .get, withParameters: nil, andHeaders: heards) { (error:String?, code:Int?, teamResult:TeamsModel?) in
            guard let result = teamResult else{
                completion("Error",ErrorsCodes.castError.rawValue,nil)
                return
            }
            if error != nil {
                completion(error,code,result)
            }else{
                //Done
                completion(nil,code,result)
            }
        }
    }
}
