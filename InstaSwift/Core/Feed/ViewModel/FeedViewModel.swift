//
//  FeedViewModel.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 06/06/23.
//

import Firebase
import Foundation

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task {
            try await fetchPosts()
        }
    }
    
    @MainActor
    func fetchPosts() async throws {
        posts = try await PostService.fetchFeedPosts()
    }
}
