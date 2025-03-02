//
//  PersistenceManager.swift
//  MatchMate
//
//  Created by Nishant Kumar on 01/03/25.
//

import Foundation
import SwiftUI
import CoreData

class PersistenceManager {
    let container: NSPersistentContainer
    weak var delegate: UserEntitySavedDelegate?
    
    init() {
        container = NSPersistentContainer(name: Constants.kUserContainerName)
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        })
    }
    
    func getUsersFromCoreData() -> [UserEntity] {
        let request = NSFetchRequest<UserEntity>(entityName: Constants.kUserEntityName)
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("Error while fetching data from CoreData: \(error)")
        }
        return []
    }
    
    func updateUserEntity(entity: UserEntity, status: ButtonStatus) {
        entity.buttonStatus = status.rawValue
        saveData()
    }
    
    func addUserToCoreData(user: User) {
        let newUser = UserEntity(context: container.viewContext)
        newUser.id = user.id
        newUser.name = Utils.getNameText(user: user)
        newUser.imageUrl = user.picture.medium
        newUser.buttonStatus = user.buttonStatus.rawValue
        newUser.address = Utils.getLocationText(user: user)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            delegate?.userEntityDidUpdated()
        } catch let error {
            print("Error while saving to core data: \(error)")
        }
    }
}
