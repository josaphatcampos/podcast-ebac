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
    
    var episode:Episodes!
    var podcast:PodCasts!
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        avplayer = nil
        
        //TODO: Remove File
    }
    
    func configlayout(){
        // image
        
        if let data = episode.imageData{
            self.coverimage.image = UIImage(data: data)
        }else if let imageUrl =  URL(string: episode.image!){
            URLSession.shared.dataTask(with: imageUrl){ data, _, error in
                guard let data = data, error == nil else {print("return session")
                    return}
                DispatchQueue.main.async {
                    self.coverimage.image = UIImage(data: data)
                }
            }.resume()
        }else{
            self.coverimage.image = UIImage(named: "imagePlaceholder")
        }
        
        
        
        titleLabel.text = episode.title
        publisherLabel.text = podcast.title
    }
        
    func playaudio(){
               
        guard let sound = episode.audio else{
            self.dismiss(animated: true)
            return
        }
        var soundUrl = URL(string: sound)!
        
        if episode.audioData != nil{
            var tempFIleURL: URL{
                return FileManager.default.temporaryDirectory.appendingPathComponent("\(episode.title!).mp3")
            }
            if !FileManager.default.fileExists(atPath: tempFIleURL.path){
                do{
                    print("try")
                    try episode.audioData?.write(to: tempFIleURL)
                }catch{
                    print("Erro \(error.localizedDescription)")
                    fatalError()
                }
                
            }
            soundUrl = tempFIleURL
        }
        
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
