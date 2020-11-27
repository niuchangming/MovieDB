//
//  Genre.swift
//  MovieDB
//
//  Created by Niu Changming on 25/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import HandyJSON

class Genre: HandyJSON {
    fileprivate let pageSize = 20
    
    var id: CLongLong = 0
    var name: String = ""
    var movies = [Movie]()
    var movieAmount: Int = 0
    var isFinished: Bool = false
    
    required init() {}
    
    func loadMovies(completed:@escaping (_ status: Status?) -> ()){
        if !isFinished {
            let pageIndex = Int(movies.count / pageSize) + 1
            let api = String(format: "%@/3/discover/movie?api_key=%@&sort_by=release_date.desc&page=%i&primary_release_date.gte=1990-01-01&primary_release_date.lte=%@&with_genres=%i", Constants.HOST, Constants.API_KEY, pageIndex, Date().toDateStr(format: "yyyy-MM-dd"), id)

            ConnectionManager.shared.request(method: .get, url: api, params: nil, succeed: { (responseJson) in
                if let model = Genre.deserialize(from: responseJson as? NSDictionary) {
                    self.movies = self.movies + model.movies
                    if self.movies.count >= model.movieAmount {
                        self.isFinished = true
                    }
                    completed(.success)
                }
            }) { (error) in
                completed(.failed(error?.localizedDescription ?? ""))
            }
        }
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.movies <-- "results"
        mapper <<<
            self.movieAmount <-- "total_results"
    }
}
