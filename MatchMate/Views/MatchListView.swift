//
//  ContentView.swift
//  MatchMate
//
//  Created by Sagar Patel on 25/01/25.
//

import SwiftUI
import CoreData

struct MatchListView: View {
    @StateObject var viewModel = MatchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users, id: \.id) { user in
                    MatchCardView(
                        user: user,
                        onAccept: { viewModel.accept(user: user) },
                        onDecline: { viewModel.decline(user: user) }
                    )
                }
            }
            .navigationTitle("Match Mate")
        }
    }
}

#Preview {
    MatchListView()
}
