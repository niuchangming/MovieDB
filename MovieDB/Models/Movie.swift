//
//  Movie.swift
//  MovieDB
//
//  Created by Niu Changming on 24/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import HandyJSON

class Movie: HandyJSON {
    var id: CLongLong = 0
    var popularity: Double = 0
    var voteCount: Int32 = 0
    var posterPath: String = ""
    var backdropPath:String = ""
    var genreIds: [Int32] = []
    var title: String = ""
    var voteAverage: Double = 0
    var overview: String = ""
    var releaseDate: String = ""
    
    var types: [String] = []
    var clickAmount: Int = 0
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.voteCount <-- "vote_count"
        mapper <<<
            self.posterPath <-- "poster_path"
        mapper <<<
            self.backdropPath <-- "backdrop_path"
        mapper <<<
            self.genreIds <-- "genre_ids"
        mapper <<<
            self.voteAverage <-- "vote_average"
        mapper <<<
            self.releaseDate <-- "release_date"
    }
    
    
}
