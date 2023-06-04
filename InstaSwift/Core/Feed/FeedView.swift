//
//  FeedView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 02/06/23.
//

import SwiftUI

struct FeedView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(Post.mockPosts) {post in
                        FeedCell(post: post)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(colorScheme == .light ? "instagram-black" : "instagram-white")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
