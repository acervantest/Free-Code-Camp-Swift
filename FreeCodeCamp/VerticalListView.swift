//
//  VerticalListView.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-18.
//

import SwiftUI
import SwiftData

struct VerticalListView: View {
    
    var titles: [Title]
    let canDelete: Bool
    @Environment(\.modelContext) var modelContext
    @State private var navigationPath = NavigationPath()
     
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                ForEach(titles) { title in
                    HStack {
                        AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                            HStack {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 10))
                                    .padding(5)
                                    .shadow(radius: 5)
                                
                                Text((title.name ?? title.title) ?? "")
                                    .font(.system(size: 14))
                                    .bold()
                            }
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 150)
                        .onTapGesture {
                            navigationPath.append(title)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        if canDelete {
                            Button {
                                modelContext.delete(title)
                                try? modelContext.save()
                            } label: {
                                Image(systemName: "trash")
                                    .tint(.red)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Title.self) { title in
                DetailView(title: title)
            }
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles, canDelete: true)
}
