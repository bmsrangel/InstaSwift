//
//  LoginView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 03/06/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme

    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(colorScheme == .light ? "instagram-black" : "instagram-white")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 220)
                VStack {
                    TextField("Enter your e-mail", text: $viewModel.email)
                        .textInputAutocapitalization(.none)
                        .modifier(ISTextViewModifier())

                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(ISTextViewModifier())
                }

                Button {
                    print("Show forgot password")
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

                Button {
                    Task {
                        try await viewModel.signIn()
                    }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(8)
                }
                .padding(.vertical)

                Divider()
                    .overlay {
                        Text("OR")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .background(Color.primary.colorInvert())
                    }
                    .padding(.horizontal)

                HStack {
                    Image("facebook-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                    Text("Continue with Facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }
                .padding(.top, 8)

                Spacer()

                Divider()

                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
