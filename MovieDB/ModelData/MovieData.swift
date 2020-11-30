//
//  MovieVM.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import HandyJSON

class MovieData: HandyJSON {
    var page: Int = 0
    var totalPages: Int = 0
    var movies = [Movie]()
    
    required init() {}
    
    func loadPlaying(completed:@escaping (_ status: Status?) -> ()) {
        let api = String(format: "%@/3/movie/now_playing?api_key=%@&page=%i", Constants.HOST, Constants.API_KEY, page + 1)

        ConnectionManager.shared.request(method: .get, url: api, params: nil, succeed: { (responseJson) in
            if let model = MovieData.deserialize(from: responseJson as? NSDictionary) {
                self.totalPages = model.totalPages
                self.page = model.page
                self.movies = model.movies
                completed(.success)
            }
        }) { (error) in
            completed(.failed(error?.localizedDescription ?? ""))
        }

    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.totalPages <-- "total_pages"
        mapper <<<
            self.movies <-- "results"
    }
    
}
