//
//  UserEntitySavedDelegateProtocol.swift
//  MatchMate
//
//  Created by Nishant Kumar on 02/03/25.
//

protocol UserEntitySavedDelegate: AnyObject {
    func userEntityDidUpdated()
    func userEntityDidFailToSaveData(with error: Error)
}
