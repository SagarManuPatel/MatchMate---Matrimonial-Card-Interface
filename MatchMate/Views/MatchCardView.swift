//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Sagar Patel on 25/01/25.
//

import SwiftUI

struct MatchCardView: View {
    let user: UserEntity
    var onAccept: () -> Void
    var onDecline: () -> Void
    
    var body: some View {
        VStack {
            if let imageURL = user.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 200) // Placeholder size
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit() // Maintains aspect ratio
                            .frame(maxWidth: .infinity)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .background(Color.black.opacity(0.4)) // Placeholder background
            }
            
            Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                .font(.headline)
            
            Text("\(user.city ?? "") \(user.state ?? "") \(user.country ?? "")")
                .font(.subheadline)
            
            
            HStack {
                Button(action: onAccept) {
                    HStack {
                        Image("accept") // Add your icon for accept
                            .foregroundColor(user.status == UserStatus.accepted.rawValue ? .white : .green) // Icon color change
                        Text("Accept")
                            .foregroundColor(user.status == UserStatus.accepted.rawValue ? .white : .green) // Text color change
                    }
                    .padding()
                    .background(user.status == UserStatus.accepted.rawValue ? Color.green : Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: onDecline) {
                    HStack {
                        Image("reject") // Add your icon for decline
                            .foregroundColor(user.status == UserStatus.declined.rawValue ? .white : .red) // Icon color change
                        Text("Decline")
                            .foregroundColor(user.status == UserStatus.declined.rawValue ? .white : .red) // Text color change
                    }
                    .padding()
                    .background(user.status == UserStatus.declined.rawValue ? Color.red : Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                .buttonStyle(PlainButtonStyle())
            }

        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0))))
        .shadow(radius: 5)
    }
}
