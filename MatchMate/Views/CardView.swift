//
//  CardView.swift
//  MatchMate
//
//  Created by Nishant Kumar on 01/03/25.
//

import SwiftUI

struct CardView: View {
    var acceptButtonAction: () -> Void
    var rejectButtonAction: () -> Void
    var imageUrl: String?
    var cachedImage: UIImage?
    var buttonStatus: ButtonStatus?
    var nameText: String?
    var locationText: String?
    var body: some View {
        VStack(alignment: .center) {
            if let image = cachedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(4)
            } else {
                AsyncImage(url: URL(string: imageUrl!)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(4)
                    case .failure:
                        Image(systemName: Constants.kDefaultPhotoImageName)
                            .foregroundColor(.gray)
                            .scaledToFit()
                            .cornerRadius(4)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding()
            }
            
            Text(nameText!)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .font(.title)
                .lineLimit(1)
                .foregroundColor(.cyan)
            Text(locationText!)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .lineLimit(2)
                .foregroundColor(.gray)
            if buttonStatus?.rawValue == "none" {
                HStack(alignment: .center, spacing: 50) {
                    Button(action: rejectButtonAction) {
                        Image(systemName: Constants.kRejectButtonImageName)
                            .foregroundColor(.cyan)
                            .font(.system(size: 50))
                            .contentShape(.rect)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .contentShape(.rect)
                    Button(action: acceptButtonAction) {
                        Image(systemName: Constants.kAcceptButtonImageName)
                            .foregroundColor(.cyan)
                            .font(.system(size: 50))
                            .contentShape(.rect)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            } else {
                Text(buttonStatus!.rawValue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .background(Color.cyan)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width - 100)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal, 40)
    }
}
