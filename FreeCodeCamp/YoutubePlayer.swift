//
//  YoutubePlayer.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-17.
//

import SwiftUI
import WebKit

struct YoutubePlayer : UIViewRepresentable {
    let webView = WKWebView()
    let videoId: String
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseUrlString = youtubeBaseURL,
              let baseURL = URL(string: baseUrlString) else {return}
        let fullURL = baseURL.appending(path: videoId)
        webView.load(URLRequest(url: fullURL))
    }
}
