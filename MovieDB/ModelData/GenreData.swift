//
//  GenreVM.swift
//  MovieDB
//
//  Created by Niu Changming on 25/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import HandyJSON

class GenreData: HandyJSON {
    var genres = [Genre]()
    
    required init() {}
    
    func load(completed:@escaping (_ status: Status?) -> ()) {
        let api = String(format: "%@/3/genre/movie/list?api_key=%@", Constants.HOST, Constants.API_KEY)

        ConnectionManager.shared.request(method: .get, url: api, params: nil, succeed: { (responseJson) in
            if let model = GenreData.deserialize(from: responseJson as? NSDictionary) {
                self.genres = model.genres
                completed(.success)
            }
        }) { (error) in
            completed(.failed(error?.localizedDescription ?? ""))
        }
        
    }
    
}
