//
//  ProfileHeaderView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 04/06/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 10) {
            // pic and status
            HStack {
                Image(user.profileImageURL ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity)
                Spacer()
                UserStatView(value: 2, title: "Posts")
                UserStatView(value: 1, title: "Followers")
                UserStatView(value: 2, title: "Following")
            }
            .padding(.horizontal)
            //                .padding(.bottom, 4)

            // Name and Bio
            VStack(alignment: .leading, spacing: 4) {
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            // Action Button
            Button {
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(
                                Color.gray, lineWidth: 1
                            )
                    )
            }

            Divider()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User.mockUsers[1])
    }
}
