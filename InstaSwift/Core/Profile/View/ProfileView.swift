//
//  ProfileView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 02/06/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: PostGridViewModel

    let user: User

    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }

    var body: some View {
        ScrollView {
            // header
            ProfileHeaderView()
            // post grid view
            PostGridView(posts: viewModel.posts)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Profile")
        .refreshable {
            Task {
                try await viewModel.fetchUserPosts()
            }
        }
        .environmentObject(viewModel)
        .onAppear {
            print("DEBUG: Post count: \(viewModel.posts.count)")
            Task {
                try await viewModel.fetchUserPosts()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.mockUsers[1])
    }
}
