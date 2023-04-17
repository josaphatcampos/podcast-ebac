//
//  DownloadTableViewCell.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 15/04/23.
//

import UIKit

class DownloadTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func btnAction(_ sender: Any) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(_ episode:Episodes, podcast:PodCasts?){
        let minhadata = Date(milliseconds:episode.pubDatems)
        let dateformate = DateFormatter()
        dateformate.locale = Locale(identifier: "pt_BR")
        dateformate.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        dateformate.dateStyle = .long
        
        if let pod = podcast{
            title.text = "\(String(describing: pod.title!)) - \(String(describing: episode.title!))"
        }else{
            title.text = episode.title!
        }
        
        
        subtitle.text = "Publicado em: \(String(describing: dateformate.string(from: minhadata)))"
    }

}
