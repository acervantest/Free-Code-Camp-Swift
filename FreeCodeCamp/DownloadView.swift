//
//  DownloadView.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-19.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    
    @Query var savedTitles: [Title]
    
    var body: some View {
        NavigationStack {
            if savedTitles.isEmpty {
                Text("No Downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            } else {
                VerticalListView(titles: savedTitles)
            }
        }
    }
}

#Preview {
    DownloadView()
}
