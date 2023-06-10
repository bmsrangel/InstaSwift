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
        
        return posts
    }

    static func fetchUserPosts(uid: String) async throws -> [Post] {
        var posts = [Post]()
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).order(by: "timestamp", descending: true).getDocuments()
        let postUser = try await UserService.fetchUser(withUid: uid)
        for i in snapshot.documents.indices {
            try posts.append(snapshot.documents[i].data(as: Post.self))
            let likedSnapshot = try await snapshot.documents[i].reference.collection("liked").getDocuments()
            posts[i].liked = likedSnapshot.documents.map({ $0.documentID })
            posts[i].user = postUser
        }

        return posts
    }
    
    static func fetchSinglePost(postId: String) async throws -> Post {
        let postRef = postsCollection.document(postId)
        var post = try await postRef.getDocument(as: Post.self)
        let likedPostRef = postRef.collection("liked")
        let snapshot = try await likedPostRef.getDocuments()
        let liked = snapshot.documents.compactMap({ $0.documentID })
        post.liked = liked
        let postOwer = try await UserService.fetchUser(withUid: post.ownerUid)
        post.user = postOwer
        return post
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
