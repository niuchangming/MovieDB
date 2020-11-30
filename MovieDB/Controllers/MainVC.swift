//
//  MoviesVC.swift
//  MovieDB
//
//  Created by Niu Changming on 25/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift
import Loaf
import FSPagerView

class MainVC: UIViewController {

    let genreVM = GenreData()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.tableFooterView = UIView()
            tableView.register(GenreCell.nib(), forCellReuseIdentifier: GenreCell.cellReuseIdentifier())
        }
    }
    
    lazy var groupQueue:DispatchGroup = {
        let gpQueue:DispatchGroup = DispatchGroup()
        return gpQueue
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .black
        loadGenres()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func loadGenres(){
        let genres = SqliteManager.shared.queryGenres(withClause: nil)
        if genres.count > 0 {
            genreVM.genres = genres
            tableView.reloadData()
        }else{
            genreVM.load { [weak self] (status) in
                guard let self = self else{ return }
                switch status {
                case .success:
                    if self.genreVM.genres.count > 0 {
                        self.saveGenres()
                        self.tableView.reloadData()
                    }else{
                        // empty view show
                    }
                    break
                case .failed(let err):
                    Loaf(err, state: .error, sender: self).show()
                    // empty view show
                    break
                default:
                    // empty view show
                    break
                }
            }
        }
    }
    
    @IBAction func viewHistoryBtnClicked(_ sender: Any) {
        let viewHistoryVC = ViewHistoryVC()
        self.navigationController?.pushViewController(viewHistoryVC, animated: true)
    }
    
    private func saveGenres(){
        SqliteManager.shared.insertGenres(genres: genreVM.genres)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreVM.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreCell.cellReuseIdentifier(), for: indexPath) as! GenreCell
        cell.parentVC = self
        cell.genre = genreVM.genres[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
