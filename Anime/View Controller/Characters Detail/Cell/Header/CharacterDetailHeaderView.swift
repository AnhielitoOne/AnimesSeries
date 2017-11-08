//
//  CharacterDetailHeaderView.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/8/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailHeaderView: UIView {

    @IBOutlet weak var pictureUIImageView: UIImageView!
    @IBOutlet weak var nameUILabel: UILabel!
    @IBOutlet weak var japaneseNameUILabel: UILabel!
    @IBOutlet weak var favoriteUILabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
            self.favoriteUILabel.isHidden = !(character?.favourite)!
        }
    }

}
