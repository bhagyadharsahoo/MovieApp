//
//  YouTubePlayer.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//

import SwiftUI
import WebKit

struct YouTubePlayer: UIViewRepresentable {
    let videoID: String
    let height: CGFloat
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .black
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let width = uiView.frame.width
        let htmlWidth = width - 20  // Small padding
        
        let embedHTML = """
        <!DOCTYPE html>
        <html style="height: 100%; margin: 0;">
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
            <style>
                html, body { 
                    height: 100%; 
                    margin: 0; 
                    padding: 0; 
                    background: #000; 
                    overflow: hidden; 
                }
                #player { 
                    width: \(htmlWidth); 
                    height: \(height); 
                }
            </style>
        </head>
        <body>
            <iframe 
                id="player"
                src="https://www.youtube.com/embed/\(videoID)?autoplay=0&playsinline=1&rel=0&modestbranding=1&iv_load_policy=3&enablejsapi=1&origin=\(originURL)&widgetid=1"
                frameborder="0" 
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
                style="position:absolute;top:0;left:0;width:100%;height:100%;">
            </iframe>
        </body>
        </html>
        """
        uiView.loadHTMLString(embedHTML, baseURL: originURL)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    private var originURL: URL {
        URL(string: "https://your-app-domain.com") ?? URL(string: "https://www.youtube.com")!
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Force reload if needed
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                webView.evaluateJavaScript("document.querySelector('iframe').contentWindow.postMessage('reload', '*')", completionHandler: nil)
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("YouTube load error: \(error)")
        }
    }
}
