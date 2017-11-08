//
//  HeaderAnimeDetailView.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/7/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit

protocol HeaderAnimeDetailViewDelegate {
    func moreInfoSelected(seriesId: Int)
}

class HeaderAnimeDetailView: UIView {

    @IBOutlet weak var banerUIImageView: UIImageView!
    @IBOutlet weak var titleUILabel: UILabel!
    var delegate : HeaderAnimeDetailViewDelegate!
    var series : Series? {
        didSet {
            self.banerUIImageView.kf.indicatorType = .activity
            if let url = URL(string: (series?.imageUrlBanner)!) {
                self.banerUIImageView.contentMode = .scaleToFill
                self.banerUIImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
            else if let url = URL(string: (series?.imageUrlLge)!) {
                self.banerUIImageView.contentMode = .scaleAspectFit
                self.banerUIImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
            
            self.titleUILabel.text = series?.titleEnglish

        }
    }
    
    @IBAction func showMoreInfoAction(_ sender: UIButton) {
        self.delegate.moreInfoSelected(seriesId: (self.series?.id!)!)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
