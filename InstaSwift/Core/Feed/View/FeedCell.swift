//
//  FeedCell.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 02/06/23.
//

import Firebase
import Kingfisher
import SwiftUI

struct FeedCell: View {
    let post: Post
    let user: User
    let onLikeTapped: () -> Void
    
    var body: some View {
        VStack {
            // image + username
            HStack {
                if let user = post.user {
                    CircularProfileImageView(user: user, size: .xSmall)
                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding(.leading, 10)

            // post image
            KFImage(URL(string: post.imageUrl)!)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            // action buttons
            HStack(spacing: 16) {
                Button {
                    onLikeTapped()
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .symbolVariant(post.liked!.contains(user.id) ? .fill : .none)
                        .foregroundColor(post.liked!.contains(user.id) ? Color(.systemRed) : .primary)
                }
                Button {
                    print("Comment post")

                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                Button {
                    print("Share post")

                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 4)
            .foregroundColor(.primary)

            // likes label
            Text("\(post.likes) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
            // caption label
            HStack {
                Text("\(post.user?.username ?? "") ")
                    .fontWeight(.semibold) +
                Text(post.caption)
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.top, 1)
            
            Text(post.timestamp.dateValue().elapsedTime())
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.gray)
                .padding(.leading, 10)
                .padding(.top, 1)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(post: Post.mockPosts[1], user: User.mockUsers[1]) {
            print("On Like Tapped")
        }
    }
}
