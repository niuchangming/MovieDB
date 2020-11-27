//
//  MovieVC.swift
//  MovieDB
//
//  Created by Niu Changming on 26/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit
import Loaf

class MovieVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var genre: Genre?{
        didSet{
            if let genre = self.genre  {
                if genre.movies.count == 0{
                    loadMovie()
                }else{
                    collectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCV()
    }
    
    fileprivate func configCV() {
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCell.nib(), forCellWithReuseIdentifier: MovieCell.cellReuseIdentifier())
    }
    
    fileprivate func loadMovie(){
        if isLoading { return }
        isLoading = true
        genre!.loadMovies() { [weak self] (status) in
            guard let self = self else{ return }
            switch status {
            case .success:
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                break
            case .failed(let err):
                Loaf(err, state: .error, sender: self).show()
                break
            default:
                Loaf("Unknown error", state: .error, sender: self).show()
            }
            self.isLoading = false
        }
    }
    
}

extension MovieVC: UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genre?.movies.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellReuseIdentifier(), for: indexPath) as! MovieCell
        
        if let genre = self.genre {
            if genre.movies.count > 0 {
                cell.movie = genre.movies[indexPath.row]
            }
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.movie = genre?.movies[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = 2 * height / 3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let genre = self.genre {
            if genre.movies.count > 0 {
                if indexPath.row == genre.movies.count - 1 {
                    loadMovie()
                }
            }
        }
    }
    
}
