//
//  TeamsNamesCell.swift
//  Football-League
//
//  Created by Tk on 04/11/2020.
//

import UIKit

class TeamsNamesCell: UITableViewCell {
    @IBOutlet weak var teamsNames:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TeamsNamesCell:TeamsNameCellView{
    func displayName(teamName: String) {
        teamsNames.text = teamName
    }
    
    
}
