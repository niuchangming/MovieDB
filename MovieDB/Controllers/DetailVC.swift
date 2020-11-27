//
//  DetailVC.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var movie: Movie?
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backIv: UIImageView!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var posterIv: UIImageView!{
        didSet{
            posterIv.clipsToBounds = true
            posterIv.layer.cornerRadius = Constants.Dimension.CORNER_SMALL_SIZE
        }
    }
    @IBOutlet weak var userScoreLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!{
        didSet{
            scoreLbl.layer.shadowColor = UIColor.black.cgColor
            scoreLbl.layer.shadowRadius = 2
            scoreLbl.layer.shadowOpacity = 0.9
            scoreLbl.layer.shadowOffset = CGSize.zero
            scoreLbl.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var scoreBar: KDCircularProgress!{
        didSet{
            scoreBar.startAngle = 0
            scoreBar.progressThickness = 0.35
            scoreBar.trackThickness = 0.3
            scoreBar.trackColor = UIColor(hexString: Constants.ColorScheme.blackColor)
            scoreBar.clockwise = true
            scoreBar.roundedCorners = false
            scoreBar.glowMode = .forward
            scoreBar.glowAmount = 1
            scoreBar.progressInsideFillColor = .clear
            scoreBar.set(colors: UIColor(hexString: Constants.ColorScheme.greenColor))
        }
    }
    @IBOutlet weak var overviewTv: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        initViews()
        countViewed()
    }
    
    fileprivate func initViews(){
        if let movie = self.movie {
            backIv.sd_setImage(with: URL(string: String(format: "https://image.tmdb.org/t/p/w1920_and_h800_multi_faces/%@", movie.backdropPath)), placeholderImage: UIImage(named: "poster_placeholder"))
            
            posterIv.sd_setImage(with: URL(string: String(format: "https://image.tmdb.org/t/p/w220_and_h330_face/%@", movie.posterPath)), placeholderImage: UIImage(named: "poster_placeholder"))
            
            titleLbl.text = movie.title
            titleLbl.numberOfLines = 0
            titleLbl.sizeToFit()
            
            releaseLbl.text = Date.stringToDate(str: movie.releaseDate).toDateStr()
            releaseLbl.font = releaseLbl.font.italic
            
            var whereClause = ""
            for genreId in movie.genreIds {
                whereClause += String(format: "genre_id=%i or ", genreId)
            }
            
            if !whereClause.isEmpty && whereClause.count > 3 {
                whereClause = "WHERE " + whereClause.dropLast(3)
                let genres = SqliteManager.shared.queryGenres(withClause: whereClause)
                if genres.count > 0{
                    typeLbl.text = genres.map({$0.name}).joined(separator: ", ")
                }
            }
            
            let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            blurredEffectView.alpha = 0.8
            backIv.addSubview(blurredEffectView)
            backIv.constrainToEdges(blurredEffectView)
            
            scoreBar.angle = movie.voteAverage / 10 * 360
            scoreLbl.text = String(format: "%i", Int(movie.voteAverage / 10 * 100))
            if movie.voteCount == 0 {
                userScoreLbl.text = "No Score"
            }else{
                userScoreLbl.text = "User Score"
            }
            
            overviewTv.text = movie.overview
        }
    }
    
    fileprivate func countViewed(){
        if let movie = self.movie {
            movie.clickAmount = SqliteManager.shared.movieViewAmount(withMovie: movie) + 1
            if movie.clickAmount > 1 {
                SqliteManager.shared.moviePlus(withMovie: movie)
            }else{
                if !SqliteManager.shared.insertMovie(movie: movie) {
                    print("Count failed")
                }
            }
        }
    }

    
}
