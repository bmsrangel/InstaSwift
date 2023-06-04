//
//  UploadPostView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 04/06/23.
//

import PhotosUI
import SwiftUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var imagePickerPresented = false
    @Binding var tabIndex: Int

    @StateObject var viewModel = UploadPostViewModel()

    var body: some View {
        VStack {
            // Action tool bar
            HStack {
                Button {
                    caption = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                    tabIndex = 0
                } label: {
                    Text("Cancel")
                }

                Spacer()

                Text("New Post")
                    .fontWeight(.semibold)

                Spacer()

                Button {
                    print("Upload")
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)

            // Post image and caption
            HStack(spacing: 8) {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                TextField("Enter your caption...", text: $caption, axis: .vertical)
            }
            .padding()

            Spacer()
        }
        .onAppear {
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0))
    }
}
