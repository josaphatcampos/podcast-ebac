//
//  EpisodesTableViewCell.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 09/04/23.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    
    var downloadDelegate:DownloadEpisodeFileDelegate?
    var index:IndexPath?
    var existDownload = false

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var playbtn: UIButton!
    
    @IBAction func playbtnAction(_ sender: Any) {
        if existDownload{
            downloadDelegate?.deleteDownloadEpisode(index!)
        }else{
            self.playbtn.setImage( UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
            downloadDelegate?.downloadEpisode(index!)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(_ episode:Episodes, indexPath:IndexPath){
        let minhadata = Date(milliseconds:episode.pubDatems)
        let dateformate = DateFormatter()
        dateformate.locale = Locale(identifier: "pt_BR")
        dateformate.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        dateformate.dateStyle = .long
        
        self.index = indexPath
        
        self.existDownload = episode.audioData != nil
        
        if self.existDownload{
//            self.playbtn.imageView?.image = UIImage(systemName: "trash.fill")
            self.playbtn.setImage( UIImage(systemName: "trash.fill"), for: .normal)
        }else{
            self.playbtn.setImage( UIImage(systemName: "square.and.arrow.down"), for: .normal)
//            self.playbtn.imageView?.image = UIImage(systemName: "square.and.arrow.down")
        }
        
        self.title.text = episode.title
        self.subtitle.text = "Publicado em: \(String(describing: dateformate.string(from: minhadata)))"
    }

}
