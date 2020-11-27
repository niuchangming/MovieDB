//
//  ViewHistoryVC.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class ViewHistoryVC: UITableViewController {

    fileprivate var movies: [Movie] = []
    var config: EmptyConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View History"
        
        config = EmptyConfig(controller: self)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.register(HistoryCell.nib(), forCellReuseIdentifier: HistoryCell.cellReuseIdentifier())
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        movies.append(contentsOf: SqliteManager.shared.queryViewHistory())
        if movies.count > 0 {
            tableView.reloadData()
        }else{
            tableView.reloadEmptyDataSet()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.cellReuseIdentifier(), for: indexPath) as! HistoryCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ViewHistoryVC: EmptyDataSetSource, EmptyDataSetDelegate{

    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return config.emptyDetailString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return config.image
    }
    
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView) -> CAAnimation? {
        return config.imageAnimation
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return config.backgroundColor
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        return config.isLoading
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -Constants.Dimension.SCREEN_HEIGHT / 10
    }
}

