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
//        print("CLICOU \(existDownload) at: \(String(describing: index?.row))")
        if existDownload{
            downloadDelegate?.deleteDownloadEpisode(index!)
        }else{
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
        
        existDownload = episode.audioData != nil
        
        if existDownload {
            print("O episódio carregou: \(String(describing: episode.title))")
            playbtn.imageView?.image = UIImage(systemName: "trash.fill")
        }
        
        title.text = episode.title
        subtitle.text = "Publicado em: \(String(describing: dateformate.string(from: minhadata)))"
    }

}
