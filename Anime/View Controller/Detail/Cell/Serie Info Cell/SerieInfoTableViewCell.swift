//
//  SerieInfoTableViewCell.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/7/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class SerieInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoTitleUILabel: UILabel!
    @IBOutlet weak var infoUILabel: UILabel!
    
    var infoTitle : String? {
        didSet {
            self.infoTitleUILabel.text = infoTitle!
        }
    }
    
    var info : String? {
        didSet {
            self.infoUILabel.text = info!
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
