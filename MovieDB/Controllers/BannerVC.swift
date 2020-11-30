//
//  BannerVC.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit
import FSPagerView
import Loaf

class BannerVC: UIViewController {
    fileprivate let movieVM = MovieData()
    fileprivate var isLoading: Bool = false
    @IBOutlet weak var viewPager: FSPagerView!{
        didSet{
            self.viewPager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PagerCell")
            self.viewPager.isInfinite = true
            self.viewPager.delegate = self
            self.viewPager.dataSource = self
            self.viewPager.automaticSlidingInterval = 3.0
            self.viewPager.transformer = FSPagerViewTransformer(type: .linear)
            self.viewPager.itemSize = CGSize(width: view.frame.size.width - 30, height: view.frame.size.height)
            self.viewPager.backgroundColor = UIColor.clear
            self.viewPager.register(BannerCell.nib(), forCellWithReuseIdentifier: BannerCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlayingMovies()
    }
    
    private func loadPlayingMovies(){
        if isLoading { return }
        isLoading = true
        loadingBar.startAnimating()
        movieVM.loadPlaying { [weak self] (status) in
            guard let self = self else{ return }
            switch status {
            case .success:
                DispatchQueue.main.async {
                    self.viewPager.reloadData()
                }
                break
            case .failed(let err):
                Loaf(err, state: .error, sender: self).show()
                break
            default:
                Loaf("Unknown error", state: .error, sender: self).show()
            }
            self.isLoading = false
            self.loadingBar.stopAnimating()
        }
    }
}

extension BannerVC: FSPagerViewDataSource, FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return movieVM.movies.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: BannerCell.cellReuseIdentifier(), at: index) as! BannerCell
        
        cell.movie  =  movieVM.movies[index]
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.movie = movieVM.movies[index]
        
        if let mainVC = self.parent {
            mainVC.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
