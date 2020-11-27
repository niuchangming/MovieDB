//
//  HistoryCell.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var posterIv: UIImageView!{
        didSet{
            posterIv.clipsToBounds = true
            posterIv.layer.cornerRadius = Constants.Dimension.CORNER_SIZE
        }
    }
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
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
            titleLbl.text = movie.title
            titleLbl.numberOfLines = 0
            titleLbl.sizeToFit()
            
            amountLbl.text = String(format: "%i", movie.clickAmount)
        }
    }
    
}
