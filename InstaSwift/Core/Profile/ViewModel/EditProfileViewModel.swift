//
//  EditProfileViewModel.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 06/06/23.
//

import Firebase
import PhotosUI
import SwiftUI

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }

    @Published var profileImage: Image?
    @Published var fullName = ""
    @Published var bio = ""

    private var uiImage: UIImage?

    init(user: User) {
        self.user = user
        if let fullname = user.fullname {
            self.fullName = fullname
        }
        if let bio = user.bio {
            self.bio = bio
        }
    }

    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }

        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        profileImage = Image(uiImage: uiImage)
    }

    func updateUserData() async throws {
        var data = [String: Any]()
        
        // update profile image if changed
        if let uiImage = uiImage {
            let imageUrl = try await ImageUploader.uploadImage(image: uiImage)
            data["profileImageURL"] = imageUrl
        }

        // update name if changed
        if !fullName.isEmpty && user.fullname != fullName {
            user.fullname = fullName
            data["fullname"] = fullName
        }

        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            user.bio = bio
            data["bio"] = bio
        }
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
            try await AuthService.shared.loadUserData()
        }
    }
}
