//
//  Utils.swift
//  MatchMate
//
//  Created by Nishant Kumar on 02/03/25.
//

class Utils {
    class func getNameText(user: User) -> String {
        return "\(user.name.first) \(user.name.last)"
    }
    
    class func getLocationText(user: User) -> String {
        return "\(user.location.street.number) \(user.location.street.name) \(user.location.city)"
    }
}
