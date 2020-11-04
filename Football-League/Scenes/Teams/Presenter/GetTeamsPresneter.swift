//
//  GetTeamsPresneter.swift
//  Football-League
//
//  Created by Tk on 04/11/2020.
//

import Foundation
protocol TeamsNameCellView{
    func displayName(teamName:String)
}
protocol GetTeamsView:class {
    func dataLoaded()
    func showErroMsg(title:String,msg:String)
    func moveToDetails(teams:Team)
}
class GetTeamsPresneter {
    private weak var view:GetTeamsView?
    private var interactor = GetTeamInteractor()
    var teamsData:TeamsModel?
    init(view:GetTeamsView) {
        self.view = view
    }
    /// calling api 
    func callGetTeamAPi()  {
        interactor.getTeams { (error, code, teams) in
            if error != nil {
                self.view?.showErroMsg(title: "Error", msg: "something wrong happen please try again later")
                return
            }
            switch code{
            case 200:
                self.teamsData = teams
                self.view?.dataLoaded()
            case 400:
                return
            default:
                return
            }
        }
    }
    // Here To send the count of data
    func sendCountToTableView() -> Int {
     return self.teamsData?.teams?.count ?? 0
    }
    // here to Dispaly Cell View
    func setupCellView(cell:TeamsNamesCell,indexRow:Int){
        cell.displayName(teamName: self.teamsData?.teams?[indexRow].name ?? "")
    }
    // Here to Select One Team To See the Team Details
    func didSelectTeam(indexRow:Int){
        self.view?.moveToDetails(teams: (self.teamsData?.teams?[indexRow])!   )
    }
}
