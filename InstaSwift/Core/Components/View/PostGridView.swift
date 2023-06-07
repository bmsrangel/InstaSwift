//
//  PostGridView.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 04/06/23.
//

import Kingfisher
import SwiftUI

struct PostGridView: View {
    @EnvironmentObject var viewModel: PostGridViewModel
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
    ]
    
    var imageDimension = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(viewModel.posts) { post in
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchUserPosts()
            }
        }
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView()
    }
}
