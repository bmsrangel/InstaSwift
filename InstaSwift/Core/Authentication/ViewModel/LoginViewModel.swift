//
//  LoginViewModel.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 04/06/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try? await AuthService.shared.login(withEmail: email, password: password)
    }
}
