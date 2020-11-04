//
//  SingleTeamVC.swift
//  Football-League
//
//  Created by Tk on 04/11/2020.
//

import UIKit

class SingleTeamVC: UIViewController {
    var singleTeam:Team?
    @IBOutlet weak var teamName:UILabel!
    @IBOutlet weak var teamColor:UILabel!
    @IBOutlet weak var teamVenue:UILabel!
    @IBOutlet weak var teamTla:UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView()  {
        teamName.text = singleTeam?.name ?? ""
        teamColor.text = singleTeam?.clubColors ?? ""
        teamVenue.text = singleTeam?.venue ?? ""
        teamTla.text = singleTeam?.tla ?? ""
    }
    @IBAction func openTeamWebSite(_ sender:UIButton){
        if let teamWebSite = storyboard?.instantiateViewController(withIdentifier: "TeamWebSiteVC") as? TeamWebSiteVC{
            teamWebSite.teamURL = singleTeam?.website ?? ""
            navigationController?.pushViewController(teamWebSite, animated: true)
        }
    }
    
}


