//
//  SearchViewModel.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 06/06/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()

    @MainActor
    func fetchAllUsers() async throws {
        users = try await UserService.fetchAllUsers()
    }
}
