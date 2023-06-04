//
//  AuthService.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 04/06/23.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import Foundation

class AuthService {
    @Published var userSession: FirebaseAuth.User?

    static let shared = AuthService()

    init() {
        userSession = Auth.auth().currentUser
    }

    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
        } catch {
            print("DEBUG: Failed to login user with error: \(error.localizedDescription)")
        }
    }

    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            await uploadUserData(uid: result.user.uid, username: username, email: email)
        } catch {
            print("DEBUG: Failed to register user with error: \(error.localizedDescription)")
        }
    }

    func loadUserData() async throws {
    }

    func signOut() {
        try? Auth.auth().signOut()
        userSession = nil
    }

    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        guard let encoded = try? Firestore.Encoder().encode(user) else { return }
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encoded)
    }
}
