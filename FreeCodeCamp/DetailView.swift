//
//  DetailView.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-17.
//

import SwiftUI

struct DetailView: View {
    
    let title: Title

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    AsyncImage(url: URL(string: title.posterPath ?? "")) { img in
                       img.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                            .frame(width: geo.size.width,
                                   height: geo.size.height)
                    }
                    .frame(width: geo.size.width,
                           height: geo.size.height * 0.85)
                    
                    Text((title.name ?? title.title) ?? "")
                        .bold()
                        .font(.title2)
                        .padding(5)
                        
                    Text(title.overview ?? "")
                        .padding(5)
                }
            }
        }
    }
}

#Preview {
    DetailView(title: Title.previewTitles[0])
}
