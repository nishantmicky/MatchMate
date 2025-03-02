//
//  UserModels.swift
//  MatchMate
//
//  Created by Nishant Kumar on 01/03/25.
//
import Foundation

enum ButtonStatus: String {
    case none = "none"
    case accepted = "accepted"
    case rejected = "rejected"
}

struct User: Identifiable, Codable {
    var id: String
    var buttonStatus: ButtonStatus = .none
    var idName: String
    var gender: String
    var name: NameDetails
    var location: LocationDetails
    var email: String
    var picture: PictureDetails
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case gender
        case name
        case location
        case email
        case picture
    }
    
    init(gender: String, name: NameDetails, location: LocationDetails, email: String, picture: PictureDetails, userID: IDDetails) {
        self.gender = gender
        self.name = name
        self.location = location
        self.email = email
        self.picture = picture
        self.id = userID.value ?? UUID().uuidString
        self.idName = userID.name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let gender = try container.decode(String.self, forKey: .gender)
        let name = try container.decode(NameDetails.self, forKey: .name)
        let location = try container.decode(LocationDetails.self, forKey: .location)
        let email = try container.decode(String.self, forKey: .email)
        let picture = try container.decode(PictureDetails.self, forKey: .picture)
        let userID = try container.decode(IDDetails.self, forKey: .userID)
        
        self.init(gender: gender, name: name, location: location, email: email, picture: picture, userID: userID)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.gender , forKey: .gender)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.location, forKey: .location)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.picture, forKey: .picture)
        let userID = IDDetails(name: self.idName, value: self.id)
        try container.encode(userID, forKey: .userID)
    }
}

struct IDDetails: Codable {
    var name: String
    var value: String?
}
        
struct NameDetails: Codable {
    var title: String
    var first: String
    var last: String
}

struct LocationDetails: Codable {
    var street: StreetDetails
    var city: String
    
}

struct StreetDetails: Codable {
    var number: Int
    var name: String
}

struct PictureDetails: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}

struct UserResults: Codable {
    var results: [User]?
}
