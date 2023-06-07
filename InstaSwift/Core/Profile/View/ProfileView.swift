//
//  ProfileView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 02/06/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: PostGridViewModel
    
    let user: User
    
    init(user: User) {
        self.user = user
        _viewModel = ObservedObject(wrappedValue: PostGridViewModel(user: user))
    }

    var body: some View {
        ScrollView {
            // header
            ProfileHeaderView(user: user)
            // post grid view
            PostGridView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Profile")
        .refreshable {
            Task {
                try await viewModel.fetchUserPosts()
            }
        }
        .environmentObject(viewModel)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.mockUsers[1])
    }
}
