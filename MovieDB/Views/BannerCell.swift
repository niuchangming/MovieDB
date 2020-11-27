//
//  BannerCell.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit
import FSPagerView

class BannerCell: FSPagerViewCell {
    @IBOutlet weak var backIv: UIImageView!{
        didSet{
            backIv.clipsToBounds = true
            backIv.layer.cornerRadius = Constants.Dimension.CORNER_LARGE_SIZE
        }
    }
    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            titleLbl.layer.shadowColor = UIColor.black.cgColor
            titleLbl.layer.shadowRadius = 2
            titleLbl.layer.shadowOpacity = 0.9
            titleLbl.layer.shadowOffset = CGSize.zero
            titleLbl.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var rateCP: KDCircularProgress!{
        didSet{
            rateCP.startAngle = 0
            rateCP.progressThickness = 0.35
            rateCP.trackThickness = 0.3
            rateCP.trackColor = UIColor(hexString: Constants.ColorScheme.blackColor)
            rateCP.clockwise = true
            rateCP.roundedCorners = false
            rateCP.glowMode = .forward
            rateCP.glowAmount = 1
            rateCP.progressInsideFillColor = .clear
            rateCP.set(colors: UIColor(hexString: Constants.ColorScheme.greenColor))
        }
    }
    @IBOutlet weak var scoreLbl: UILabel!{
        didSet{
            scoreLbl.layer.shadowColor = UIColor.black.cgColor
            scoreLbl.layer.shadowRadius = 2
            scoreLbl.layer.shadowOpacity = 0.9
            scoreLbl.layer.shadowOffset = CGSize.zero
            scoreLbl.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var userScoreLbl: UILabel!{
        didSet{
            userScoreLbl.layer.shadowColor = UIColor.black.cgColor
            userScoreLbl.layer.shadowRadius = 2
            userScoreLbl.layer.shadowOpacity = 0.9
            userScoreLbl.layer.shadowOffset = CGSize.zero
            userScoreLbl.layer.masksToBounds = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func cellReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    public var movie = Movie() {
        didSet {
            self.contentView.layer.shadowRadius = Constants.Dimension.CORNER_SIZE
            self.contentView.layer.shadowColor = UIColor.black.cgColor
            self.contentView.layer.shadowOpacity = 0.6
            self.contentView.layer.shadowOffset = .zero
            
            backIv.sd_setImage(with: URL(string: String(format: "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/%@", movie.backdropPath)), placeholderImage: UIImage(named: "poster_placeholder"))
            
            titleLbl.text = movie.title
            titleLbl.numberOfLines = 0
            titleLbl.sizeToFit()
        
            rateCP.angle = movie.voteAverage / 10 * 360
            scoreLbl.text = String(format: "%i", Int(movie.voteAverage / 10 * 100))
        }
    }
    

}
