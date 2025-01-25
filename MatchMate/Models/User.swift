//
//  User.swift
//  MatchMate
//
//  Created by Sagar Patel on 25/01/25.
//

import Foundation

enum UserStatus: String {
    case pending = "Pending"
    case accepted = "Accepted"
    case declined = "Declined"
}

struct User: Decodable {
    var id: UserID?
    let name: Name?
    let picture: Picture?
    let login: Login?
    let location: UsersLocation?

    struct Name: Decodable {
        let first: String?
        let last: String?
    }

    struct Picture: Decodable {
        let large: String?
    }

    struct Login: Decodable {
        let uuid: String?
    }
    
    struct UserID: Decodable {
        let name: String?
        let value: String?
    }
    
    struct UsersLocation: Codable {
        let city: String?
        let state: String?
        let country: String?
    }
}
