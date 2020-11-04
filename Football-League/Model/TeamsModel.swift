//
//  TeamsModel.swift
//  Football-League
//
//  Created by Tk on 03/11/2020.
//

import Foundation



struct TeamsModel : Codable {
    let competition: Competition?
    let teams: [Team]?
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int?
    let name, plan: String?
}


// MARK: - Winner
struct Winner: Codable {
    let name, shortName, tla: String?
    let crestURL: String?

    enum CodingKeys: String, CodingKey {
        case  name, shortName, tla
        case crestURL = "crestUrl"
    }
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    
    let name, shortName, tla: String?
    let crestURL: String?
    let address, phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case id, name, shortName, tla
        case crestURL = "crestUrl"
        case address, phone, website, email, founded, clubColors, venue, lastUpdated
    }
}
