//
//  ProfileView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 02/06/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User

    var body: some View {
        ScrollView {
            // header
            ProfileHeaderView(user: user)
            // post grid view
            PostGridView(user: user)
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
