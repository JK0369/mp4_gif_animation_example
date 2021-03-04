//
//  ViewController.swift
//  VideoExample
//
//  Created by 김종권 on 2021/03/04.
//

import UIKit
import AVFoundation
import Gifu

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIImageView!
    @IBOutlet weak var gifAnimationView: GIFImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playGifVideo()
    }

    private func playGifVideo() {
        DispatchQueue.main.async { [weak self] in
            self?.gifAnimationView.animate(withGIFNamed: "start", loopCount: 1, animationBlock:  { [weak self] in
                self?.gifAnimationView.animate(withGIFNamed: "end")
            })
        }
    }

    private func playMp4Video() {
        DispatchQueue.main.async { [weak self] in
            self?.playVideo(with: "start_")
        }

        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.5) { [weak self] in
            self?.playVideo(with: "end_")
        }
    }

    private func playVideo(with resourceName: String) {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "mp4") else {
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = animationView.bounds
        animationView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        player.play()
    }
}
