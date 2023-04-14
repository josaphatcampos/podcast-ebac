//
//  PlayerViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 13/04/23.
//

import UIKit
import AVFoundation
import AVKit

class PlayerViewController: UIViewController {
    
    var audiourl = "https://tuningmania.com.br/autosom/mp3/0-intro%20to%20test%20section.MP3"
//    var audiourl = "https://www.listennotes.com/e/p/1a4c6fd9edbe4c629c16d7073ac1e1f6/"
    var player:AVAudioPlayer?
    
    var playerItem: AVPlayerItem!
    var avplayer:AVPlayer!
    
    @IBOutlet weak var coverimage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBOutlet weak var tempSlider: UISlider!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var previusButton: UIButton!
    
    @IBOutlet weak var totalTimeText: UILabel!
    
    @IBOutlet weak var currentTimeText: UILabel!
    
    @IBAction func playerAction(_ sender: Any)  {
        
        if avplayer.timeControlStatus == .playing {
            avplayer.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }else{
            avplayer.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
    }
    
    @IBAction func previusAction(_ sender: Any) {
    }
    
    @IBAction func changeAudioTime(_ sender: UISlider) {
        avplayer.seek(to: CMTime(seconds: Double(sender.value) * playerItem.duration.seconds, preferredTimescale: 1))
    }
    
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        configlayout()
        playaudio()
    }
    
    func configlayout(){
        // image
        guard let imageUrl = URL(string: "https://production.listennotes.com/podcasts/flow-podcast/guto-zacarias-kim-kataguiri-jfB7Irahzet-G7pIBciktqn.300x300.jpg") else{
            self.coverimage.image = UIImage(named: "imagePlaceholder")
            return
        }
        
        
        URLSession.shared.dataTask(with: imageUrl){ data, _, error in
            guard let data = data, error == nil else {print("return session")
                return}
            DispatchQueue.main.async {
                self.coverimage.image = UIImage(data: data)
            }
        }.resume()
        
        titleLabel.text = "GUTO ZACARIAS + KIM KATAGUIRI - Flow #197"
        publisherLabel.text = "Flow Podcast"
    }
    
//    func downloadFIleFromURL(url:URL) {
//        URLSession.shared.downloadTask(with: url){ data, _, error in
//            guard let data = data, error == nil else{return}
//            print("baixou o trem aqui: \(data)")
//            self.playurl(url: data)
//
//        }.resume()
//
//    }
//
//    func playurl(url:URL) {
//
//        do{
//            print("do")
//
//            DispatchQueue.main.async {
//                let playerViewController = AVPlayerViewController()
//                self.present(playerViewController, animated: true, completion: nil)
//
//                let player = AVPlayer(url: url)
//                playerViewController.player = player
//                player.play()
//            }
//
////            self.player = try AVAudioPlayer(contentsOf: url)
////            guard let player = player else{return}
////            player.prepareToPlay()
////            player.volume = 1.0
////            player.play()
////            print("depois do play")
//
//
//
//
////            try AVAudioSession.sharedInstance().setMode(.default)
////            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
////            print("antes audio url")
////            guard let audiourl =  Bundle.main.path(forResource: String(describing: url), ofType: "mp3") else{
////                return
////            }
////            print("depois audio url")
////            player = try AVAudioPlayer(contentsOf: URL(string: audiourl)!)
////            print("depois do try")
////            guard let player = player else {
////                return
////            }
////            print("antes do play")
////            player.prepareToPlay()
////            player.volume = 1.0
////            player.play()
////            print("depois do play")
////            playButton.setImage(UIImage(named: "pause.fill"), for: .normal)
//
//
//
//
//            //https://stackoverflow.com/questions/34563329/how-to-play-mp3-audio-from-url-in-ios-swift
////            let playerItem = AVPlayerItem.init(url: URL.init(string: audiourl)!)
////            let p = AVPlayer.init(playerItem: playerItem)
////
////            tempSlider.minimumValue = 0
////            let duration:CMTime = try  await playerItem.asset.load(.duration)
////            let seconds: Float64 = CMTimeGetSeconds(duration)
//////            print(localizedString(fromTimeInterval: seconds))
////            print(String(describing: duration))
////
////            let currentDuration : CMTime = playerItem.currentTime()
////            let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
////            print(String(describing: currentSeconds))
////
////            tempSlider.maximumValue = Float(seconds)
////            tempSlider.isContinuous = true
////
////
////            print("antes do play")
////            p.play()
////            print("depois do plauy")
//
//
//
//        }catch{
//            print("deu ruim")
//        }
//    }
    
    func playaudio(){
//        let soundUrl =  Bundle.main.url(forResource: audiourl, withExtension: "mp3")!
        
        let soundUrl = URL(string: audiourl)!
        playerItem = AVPlayerItem(url: soundUrl)
        avplayer =  AVPlayer(playerItem: playerItem)
        avplayer.volume = 1.0
        avplayer.play()
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        avplayer.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: nil) { (time) in
            let percent = time.seconds / self.playerItem.duration.seconds
            self.tempSlider.setValue(Float(percent), animated: true)
            
            if time.isValid {
                self.totalTimeText.text = self.formatTime(duration: self.playerItem.duration)
                self.currentTimeText.text = self.formatTime(duration: time)
            }
            
        }
        
        
    }
    
    func formatTime(duration: CMTime)->String{
        
        let totalSeconds:TimeInterval = TimeInterval(duration.seconds.rounded())
        
        if totalSeconds.isNaN || !totalSeconds.isFinite{
            return "00:00"
        }
        
        var hours:  Int64 { return Int64(totalSeconds / 3600)  }
        var minute: Int64 { return Int64(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60) }
        var second: Int64 { return Int64(totalSeconds.truncatingRemainder(dividingBy: 60)) }
       
        return hours > 0 ?
            String(format: "%d:%02d:%02d", hours, minute, second) :
            String(format: "%02d:%02d", minute, second)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
