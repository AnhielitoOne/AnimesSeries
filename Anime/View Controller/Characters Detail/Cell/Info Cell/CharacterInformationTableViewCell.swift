//
//  CharacterInformationTableViewCell.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/8/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class CharacterInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var infoUITextView: UITextView!
    
    var info : String? {
        didSet {
            print(info!)
            self.infoUITextView.text = info!
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
