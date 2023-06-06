//
//  ProfileView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 02/06/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User

    var posts: [Post] {
        return Post.mockPosts.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        ScrollView {
            // header
            ProfileHeaderView(user: user)
            // post grid view
            PostGridView(posts: posts)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.mockUsers[1])
    }
}
