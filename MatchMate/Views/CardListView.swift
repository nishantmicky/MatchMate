//
//  CardListView.swift
//  MatchMate
//
//  Created by Nishant Kumar on 28/02/25.
//

import SwiftUI

struct CardListView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView(Constants.kLoadingText)
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.savedUsers) { entity in
                            if let imageUrl = entity.imageUrl, let name = entity.name, let address = entity.address, let statusRaw = entity.buttonStatus, let status = ButtonStatus(rawValue: statusRaw) {
                                CardView(acceptButtonAction: {
                                    viewModel.updateButtonStatus(entity: entity, status: .accepted)
                                }, rejectButtonAction: {
                                    viewModel.updateButtonStatus(entity: entity, status: .rejected)
                                }, imageUrl: imageUrl,
                                         cachedImage: viewModel.fetchCachedImage(url: imageUrl),
                                         buttonStatus: status,
                                         nameText: name,
                                         locationText: address)
                                .background(Color.gray.opacity(0.1))
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(Constants.kNavigationTitleText)
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
    }
}
