//
//  EpisodesTableViewCell.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 09/04/23.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var playbtn: UIButton!
    
    @IBAction func playbtnAction(_ sender: Any) {
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(_ episode:Episode){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        
        let datapubli = dateformatter.date(from: String(describing: Date(timeIntervalSince1970: TimeInterval(episode.pubDateMS))))
        
        title.text = episode.title
        subtitle.text = "Publicado em: \(String(describing: datapubli))"
    }

}
