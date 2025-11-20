//
//  SearchView.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-19.
//

import SwiftUI

struct SearchView: View {

    @State private var searchByMovies = true
    @State private var searchText = ""
    private let searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                
                if let error =  searchViewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(Color.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
                    ForEach(searchViewModel.searchTitles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                        .onTapGesture {
                            navigationPath.append(title)
                        }
                    }
                }
            }
            .padding(.top, 1)
            .navigationTitle(searchByMovies ?
                             Constants.movieSearchString : Constants.tvSearchString
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        searchByMovies.toggle()
                        
                        Task {
                            await searchViewModel.fetchSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
                        }
                        
                    } label: {
                        Image(systemName: searchByMovies ?
                              Constants.movieIconString : Constants.tvIconString
                        )
                    }
                }
            }
            .searchable(text: $searchText, prompt: searchByMovies ?
                        Constants.moviePlaceholderString : Constants.tvPlaceholderString )
            .task(id: searchText) {
                try? await Task.sleep(for: .milliseconds(500))
                
                if Task.isCancelled {
                    return
                }
                
                await searchViewModel.fetchSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
            }
            .navigationDestination(for: Title.self) { title in
                DetailView(title: title)
            }
        }
    }
}

#Preview {
    SearchView()
}
