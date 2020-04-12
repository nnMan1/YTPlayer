//
//  YoutupePlayer.swift
//  YTPlayer
//
//  Created by Velibor Došljak on 28/02/2020.
//  Copyright © 2020 Velibor Došljak. All rights reserved.
//

import UIKit
import WebKit

class YouTubePlayer: UIView {

    private var webView: WKWebView!
    
    var playsInline = 0
    var showControls = 1
    var autoPlay = false
    var isLogoHidden = false
    var isTitleHidden = false
    
    override func awakeFromNib() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.preferences.javaScriptEnabled = true
        webConfiguration.mediaPlaybackRequiresUserAction = false
        
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
                
        self.addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.layoutIfNeeded()
    }
    
    func load(withVideoId videoId: String) {
        var stylesToEmbed = ""
        
        if let url = URL(string: "https://www.youtube.com/embed/\(videoId)?enablejsapi=1&playsinline=\(playsInline)&controls=\(showControls)&rel=0") {
            webView.load(URLRequest(url: url))
        }
        
        webView.navigationDelegate = self

//        webView.load(HTML: """
//                            <script>
//                                    videoId = '\(videoId)';
//                                    autoplay = \(autoPlay ? 1 : 0);
//                                    playsinline = \(playsInline);
//                            </script>
//                        """
//                        , cssFiles: [], javascriptFiles: ["YoutubePlayer.js"])
    }
    
    func playVideo() {
        webView.evaluateJavaScript("player.playVideo()", completionHandler: nil)
    }
    
    func pauseVideo() {
        webView.evaluateJavaScript("player.pauseVideo()", completionHandler: nil)
    }

    func stopVideo() {
        webView.evaluateJavaScript("player.stopVideo()", completionHandler: nil)
    }
    
    func seekTo(seconds: Int) {
        webView.evaluateJavaScript("player.seekTo(\(seconds)", completionHandler: nil)
    }
    
    func showLogo() {
        isLogoHidden = false
        webView.evaluateJavaScript("chanelLogo.style.display = 'block'", completionHandler: nil)
    }
    
    func hideLogo() {
        isLogoHidden = true
        webView.evaluateJavaScript("chanelLogo.style.display = 'none'", completionHandler: nil)
    }
    
    func showTitle() {
        isTitleHidden = false
        webView.evaluateJavaScript("title.style.display = 'block'", completionHandler: nil)
    }
    
    func hideTitle() {
        isTitleHidden = true
        webView.evaluateJavaScript("title.style.display = 'none'", completionHandler: nil)
    }
}

extension YouTubePlayer: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript( """
                                        var player = document.querySelector('.html5-video-player')
                                        var chanelLogo = document.querySelector('.ytp-title-channel-logo')
                                        var title = document.querySelector('.ytp-title-link')
                                    """, completionHandler: nil)
        if(autoPlay) { playVideo() }
        if(isLogoHidden) { hideLogo() }
        if(isTitleHidden) { hideTitle() }
        printClsses(view: webView)
        print("end")
    }
    
    func printClsses(view: UIView) {
        print(view.self)
        for subview in view.subviews {
            printClsses(view: subview)
        }
    }
}
