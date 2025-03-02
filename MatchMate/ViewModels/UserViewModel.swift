//
//  UserViewModel.swift
//  MatchMate
//
//  Created by Nishant Kumar on 01/03/25.
//

import Foundation
import UIKit
import CoreData

class UserViewModel: ObservableObject {
    @Published var savedUsers: [UserEntity] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let persistenceManager = PersistenceManager()
    private let apiManager = APIManager.shared
    private let downloadmanager = ImageDownloadManager.shared
    
    init() {
        persistenceManager.delegate = self
        self.savedUsers = self.persistenceManager.getUsersFromCoreData()
        if savedUsers.isEmpty {
            isLoading = false
        }
    }
    
    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        
        apiManager.fetchUserData() { (result: Result<[User], APiError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let users):
                    for user in users {
                        self.persistenceManager.addUserToCoreData(user: user)
                    }
                    self.savedUsers = self.persistenceManager.getUsersFromCoreData()
                    self.downloadImages()
                case .failure(let error):
                    self.savedUsers = self.persistenceManager.getUsersFromCoreData()
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func updateButtonStatus(entity: UserEntity, status: ButtonStatus) {
        persistenceManager.updateUserEntity(entity: entity, status: status)
    }
    
    func fetchCachedImage(url: String) -> UIImage? {
        return downloadmanager.fetchImageFromCache(url: url)
    }
    
    // MARK: - Image download methods
    private func downloadImages() {
        var imageUrls: [String] = []
        for entity in savedUsers {
            if let imageUrl = entity.imageUrl {
                imageUrls.append(imageUrl)
            }
        }
        downloadmanager.downloadImages(from: imageUrls)
    }
}

// MARK: - User Entity saved delegate methods
extension UserViewModel: UserEntitySavedDelegate {
    func userEntityDidUpdated() {
        self.savedUsers = self.persistenceManager.getUsersFromCoreData()
    }
    
    func userEntityDidFailToSaveData(with error: any Error) {
        print("Error while saving into core data: \(error.localizedDescription)")
    }
}
