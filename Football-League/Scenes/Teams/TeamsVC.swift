//
//  ViewController.swift
//  Football-League
//
//  Created by Tk on 03/11/2020.
//

import UIKit

class TeamsVC: UIViewController {
    @IBOutlet weak var teamsTable:UITableView!
    var presenter:GetTeamsPresneter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = GetTeamsPresneter(view:self)
        setubViews()
    }


}

extension TeamsVC: GetTeamsView{
    func moveToDetails(teams: Team) {
        if let singleTeam = storyboard?.instantiateViewController(withIdentifier: "SingleTeamVC") as?SingleTeamVC{
            singleTeam.singleTeam = teams
            navigationController?.pushViewController(singleTeam, animated: true)
        }
        
    }
    
    func dataLoaded() {
        teamsTable.reloadData()
    }
    
    func showErroMsg(title: String, msg: String) {
        alertUserWithHandler(title: title, message: msg) { (action) in
            
        }
    }
    
    
    
    
}
extension TeamsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sendCountToTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsNamesCell", for: indexPath) as? TeamsNamesCell{
            presenter.setupCellView(cell: cell, indexRow: indexPath.row)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectTeam(indexRow: indexPath.row)
    }
}
extension TeamsVC{
    private func setubViews(){
        presenter.callGetTeamAPi()
        teamsTable.delegate = self
        teamsTable.dataSource = self
        teamsTable.register(UINib(nibName: "TeamsNamesCell", bundle: nil), forCellReuseIdentifier: "TeamsNamesCell")
    }
}
