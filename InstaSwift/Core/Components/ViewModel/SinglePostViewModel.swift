//
//  SinglePostViewModel.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 08/06/23.
//

import Foundation

class SinglePostViewModel: ObservableObject {
    @Published var post: Post?
    
    @MainActor
    func toggleLike(uid: String) async throws {
        try await PostService.toggleLike(postId: post!.id, uid: uid)

        if post!.liked!.contains(uid) {
            post!.likes -= 1
            post!.liked!.removeAll(where: { $0 == uid })
        } else {
            post!.likes += 1
            post!.liked!.append(uid)
        }
    }
    
    @MainActor
    func fetchPostData(postId: String) async throws {
        post = try await PostService.fetchSinglePost(postId: postId)
    }
}
