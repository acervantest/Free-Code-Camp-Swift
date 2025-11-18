//
//  ViewModel.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-16.
//

import Foundation

@Observable
class ViewModel {
    
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTv: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTv: [Title] = []
    var heroTitle = Title.previewTitles[0]
    
    func getTitles() async { 
        homeStatus = .fetching
        
        if trendingMovies.isEmpty {
            do {
                async let trendingMov = dataFetcher.fetchTitles(for: "movie", by: "trending")
                async let trendingT = dataFetcher.fetchTitles(for: "tv", by: "trending")
                async let topRatedMov = dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let topRatedT = dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                
                trendingMovies = try await trendingMov
                trendingTv = try await trendingT
                topRatedMovies = try await topRatedMov
                topRatedTv = try await topRatedT
                
                if let title = trendingMovies.randomElement() {
                    heroTitle = title
                }
                
                homeStatus = .success
            } catch {
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        } else {
            homeStatus = .success
        }
    }
}
