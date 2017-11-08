//
//  AnimeCoverCollectionViewCell.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/5/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import Kingfisher

class AnimeCoverCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverUIImageView: UIImageView!
    
    var series : Series? {
        didSet {
            let url = URL(string: (series?.imageUrlLge)!)
            self.coverUIImageView.kf.indicatorType = .activity
            self.coverUIImageView.contentMode = .scaleToFill
            self.coverUIImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

}
