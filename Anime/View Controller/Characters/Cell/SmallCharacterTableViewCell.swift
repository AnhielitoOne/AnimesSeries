//
//  SmallCharacterTableViewCell.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/7/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import Kingfisher

class SmallCharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureUIImageView: UIImageView!
    @IBOutlet weak var nameUILabel: UILabel!
    @IBOutlet weak var japaneseNameUILabel: UILabel!
    @IBOutlet weak var favoriteUIImageView: UIImageView!
    
    var character : Character? {
        didSet {
            self.pictureUIImageView.kf.indicatorType = .activity
            if let url = URL(string: (character?.imageUrlMed)!) {
                self.pictureUIImageView.contentMode = .scaleToFill
                self.pictureUIImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
            let name = (character?.nameFirst)! + " " + (character?.nameLast)!
            self.nameUILabel.text = name
            self.japaneseNameUILabel.text = character?.nameJapanese
            self.favoriteUIImageView.isHidden = !(character?.favourite)!
            
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
    
}
