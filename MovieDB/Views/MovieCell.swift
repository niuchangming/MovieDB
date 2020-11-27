//
//  MovieCell.swift
//  MovieDB
//
//  Created by Niu Changming on 26/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var posterIv: UIImageView!{
        didSet{
            posterIv.clipsToBounds = true
            posterIv.layer.cornerRadius = Constants.Dimension.CORNER_SIZE
        }
    }
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateBgView: UIView!{
        didSet{
            dateBgView.clipsToBounds = true
            dateBgView.layer.cornerRadius = Constants.Dimension.CORNER_SIZE
            dateBgView.layer.maskedCorners = [.layerMinXMaxYCorner]
        }
    }
    @IBOutlet weak var maskBgView: GradientView!{
        didSet{
            maskBgView.clipsToBounds = true
            maskBgView.layer.cornerRadius = Constants.Dimension.CORNER_SIZE
            maskBgView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func cellReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    public var movie = Movie() {
        didSet {
            posterIv.sd_setImage(with: URL(string: String(format: "https://image.tmdb.org/t/p/w220_and_h330_face/%@", movie.posterPath)), placeholderImage: UIImage(named: "poster_placeholder"))
            nameLbl.text = movie.title
            nameLbl.numberOfLines = 0
            nameLbl.sizeToFit()
            
            dateLbl.text = Date.stringToDate(str: movie.releaseDate).toDateStr()
        }
    }

}
