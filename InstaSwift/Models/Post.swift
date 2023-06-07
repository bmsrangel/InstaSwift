//
//  Post.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 04/06/23.
//

import Firebase
import Foundation

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    var user: User?
}

extension Post {
    static var mockPosts: [Post] = [
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "This is some test caption for now",
            likes: 123,
            imageUrl: "batman-2",
            timestamp: Timestamp(),
            user: User.mockUsers[0]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "Wakanda Forever",
            likes: 104,
            imageUrl: "black-panther-1",
            timestamp: Timestamp(),
            user: User.mockUsers[3]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "TIton Man",
            likes: 12,
            imageUrl: "ironman-1",
            timestamp: Timestamp(),
            user: User.mockUsers[2]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "Venom is hungry. Time to eat",
            likes: 314,
            imageUrl: "venom-1",
            timestamp: Timestamp(),
            user: User.mockUsers[1]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "This is some test caption for now",
            likes: 76,
            imageUrl: "venom-2",
            timestamp: Timestamp(),
            user: User.mockUsers[1]
        ),
    ]
}
