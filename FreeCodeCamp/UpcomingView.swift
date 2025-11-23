//
//  UpcomingView.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-18.
//

import SwiftUI

struct UpcomingView: View {
    
    let viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                case .success:
                    VerticalListView(titles: viewModel.upcomingMovies, canDelete: false)
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                }
            }
            .task {
                await viewModel.getUpcomingMovies()
            }
        }
        
    }
}

#Preview {
    UpcomingView()
}
