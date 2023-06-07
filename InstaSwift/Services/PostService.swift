//
//  PostService.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 06/06/23.
//

import Firebase
import FirebaseFirestore
import Foundation

struct PostService {
    private static let postsCollection = Firestore.firestore().collection("posts")

    static func fetchFeedPosts() async throws -> [Post] {
        var posts = [Post]()
        let snapshot = try await postsCollection.order(by: "timestamp", descending: true).getDocuments()
        for i in snapshot.documents.indices {
            try posts.append(snapshot.documents[i].data(as: Post.self))
            let likedSnapshot = try await snapshot.documents[i].reference.collection("liked").getDocuments()
            posts[i].liked = likedSnapshot.documents.map({ $0.documentID })
            let ownerUid = posts[i].ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
//        for i in 0 ..< posts.count {
//            let post = posts[i]
//            let ownerUid = post.ownerUid
//            let postUser = try await UserService.fetchUser(withUid: ownerUid)
//            posts[i].user = postUser
//        }

        return posts
    }

    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        let posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })

        return posts
    }
    
    static func toggleLike(postId: String, uid: String) async throws {
        let likedCollectionRef = postsCollection.document(postId).collection("liked")
        let snapshot = try await likedCollectionRef.whereField("userUid", isEqualTo: uid).getDocuments()
        if snapshot.count == 0 {
            try await postsCollection.document(postId).updateData(["likes": FieldValue.increment(1.0)])
            let likedUserRef = likedCollectionRef.document(uid)
            try await likedUserRef.setData(["userUid": uid])
        } else {
            try await postsCollection.document(postId).updateData(["likes": FieldValue.increment(-1.0)])
            let likedUserRef = likedCollectionRef.document(uid)
            try await likedUserRef.delete()
            
        }
    }
}
