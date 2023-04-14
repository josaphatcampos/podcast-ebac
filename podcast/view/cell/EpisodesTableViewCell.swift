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
        let minhadata = Date(milliseconds:episode.pubDateMS)
        let dateformate = DateFormatter()
        dateformate.locale = Locale(identifier: "pt_BR")
        dateformate.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        dateformate.dateStyle = .long
        
        
        
        
        title.text = episode.title
        subtitle.text = "Publicado em: \(String(describing: dateformate.string(from: minhadata)))"
    }

}
