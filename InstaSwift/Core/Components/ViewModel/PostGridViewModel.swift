//
//  PostGridViewModel.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 06/06/23.
//

import Foundation

class PostGridViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    
    var postsCount: Int {
        posts.count
    }
    
    init(user: User) {
        self.user = user
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in 0..<posts.count {
            posts[i].user = self.user
        }
    }
}
