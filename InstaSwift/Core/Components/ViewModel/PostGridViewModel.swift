//
//  PostGridViewModel.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 06/06/23.
//

import Foundation

class PostGridViewModel: ObservableObject {
    let user: User
    @Published var posts = [Post]()
    var isDataFetched = false

    var postsCount: Int {
        posts.count
    }

    init(user: User) {
        self.user = user
    }

    @MainActor
    func fetchUserPosts() async throws {
        if !isDataFetched {
            posts = try await PostService.fetchUserPosts(uid: user.id)
            isDataFetched = true
        }
    }
}
