//
//  ViewController.swift
//  YTPlayer
//
//  Created by Velibor Došljak on 28/02/2020.
//  Copyright © 2020 Velibor Došljak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ytPlayer: YouTubePlayer!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ytPlayer.autoPlay = true
        ytPlayer.playsInline = 1
        ytPlayer.showControls = 1
        ytPlayer.load(withVideoId: "bOHysWYMZM0")
    }

    @IBAction func playVideo(_ sender: Any) {
        ytPlayer.playVideo()
    }
    
    @IBAction func stopVideo(_ sender: Any) {
        ytPlayer.stopVideo()
    }
    
    @IBAction func hideControlls(_ sender: Any) {
        ytPlayer.hideLogo()
        ytPlayer.hideTitle()
    }
    
    @IBAction func pauseVideo(_ sender: Any) {
        ytPlayer.pauseVideo()
    }
    
    @IBAction func showLogo(_ sender: Any) {
        ytPlayer.showLogo()
        ytPlayer.showTitle()
    }
    
    
}

