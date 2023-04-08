//
//  HomeCellTableViewCell.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

import UIKit

class HomeCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var download: UIButton!
    
    @IBAction func downloadAction(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumb.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with podcast: Podcast){
        title.text = podcast.title
        subtitle.text = podcast.publisher
        
        guard let imageUrl = URL(string: podcast.thumbnail) else{return}
        
        URLSession.shared.dataTask(with: imageUrl){data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.thumb.image = UIImage(data: data)
            }
            
        }.resume()
        
    }

}
