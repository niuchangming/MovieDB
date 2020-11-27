//
//  GenreCell.swift
//  MovieDB
//
//  Created by Niu Changming on 26/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit

class GenreCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieContainer: UIView!
    @IBOutlet weak var movieContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var indicatorView: UIView!{
        didSet{
            indicatorView.clipsToBounds  = true
            indicatorView.layer.cornerRadius = Constants.Dimension.CORNER_SMALL_SIZE
        }
    }
    
    lazy var movieVC: MovieVC = {
        let movieVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieVC") as! MovieVC
        return movieVC
    }()
    
    var parentVC: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieContainerHeight.constant = Constants.Dimension.SCREEN_HEIGHT / 4
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func cellReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    public var genre = Genre() {
        didSet {
            self.titleLbl.text = genre.name
            self.configMovieCV()
            self.movieVC.collectionView.setContentOffset(.zero, animated: false)
        }
    }
    
    fileprivate func configMovieCV(){
        clearMovieContainer()
        
        movieVC.genre = genre
        movieVC.view.frame = movieContainer.frame
        
        parentVC?.addChild(movieVC)
        movieContainer.addSubview(movieVC.view)
        movieContainer.constrainToEdges(movieVC.view)
        movieVC.didMove(toParent: parentVC)
    }
    
    fileprivate func clearMovieContainer(){
        for view in movieContainer.subviews {
            view.removeFromSuperview()
        }
    }

}
