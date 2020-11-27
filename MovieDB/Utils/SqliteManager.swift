//
//  SqliteManager.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit
import SQLite3

class SqliteManager {
    static let shared = SqliteManager()
    static let MOVIE_TB: String = "movie"
    static let GENRE_TB: String = "genre"
    let dbName = ""
    var dbFileUrl: URL?
    
    private init() {
        if dbFileUrl == nil {
            dbFileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("movie_db.sqlite")
        }
    }
    
    func getPath(fileName: String) -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.path
    }
    
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        if sqlite3_open(dbFileUrl?.absoluteString, &db) == SQLITE_OK {
            return db
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            return nil
        }
    }
    
    func tableExists(tableName: String) -> Bool {
        let db = openDatabase()
        
        var isExist: Bool = false
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, String(format: "SELECT name FROM sqlite_master WHERE type='table' AND name='%@';", tableName), -1, &insertStatement, nil) == SQLITE_OK {
            if sqlite3_step(insertStatement) == SQLITE_ROW {
                isExist = true
            }
        }
        
        sqlite3_finalize(insertStatement)
        
        return isExist
    }
    
    func createMovieTable(){
        let db = openDatabase()
        defer { sqlite3_finalize(createTableStatement) }
        
        let createTableString = String(format: "CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, movie_id INTEGER, popularity REAL, vote_count INTEGER, vote_average REAL, release_date VARCHAR, title VARCHAR, overview TEXT, poster_path VARCHAR, backdrop_path VARCHAR, genre_ids VARCHAR, click_amount INTEGER);", SqliteManager.MOVIE_TB)
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Table created.")
            } else {
                print("Table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
    }
    
    func createGenreTable(){
        let db = openDatabase()
        let createTableString = String(format: "CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, genre_id INTEGER, name VARCHAR);", SqliteManager.GENRE_TB)
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Table created.")
            } else {
                print("Table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertGenres(genres: [Genre]) {
        let db = openDatabase()
        defer { sqlite3_finalize(insertStatement) }
        
        let insertStatementString = String(format: "INSERT INTO %@ (genre_id, name) VALUES (?, ?);", SqliteManager.GENRE_TB)
        
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            for genre in genres {
                sqlite3_bind_int(insertStatement, 1, Int32(genre.id))
                sqlite3_bind_text(insertStatement, 2, genre.name, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Genre Row inserted")
                }else{
                    print("Genre Row inserted failed")
                }
                
                if (sqlite3_reset(insertStatement) != SQLITE_OK){
                    print("Could not reset row.")
                }
            }
        } else {
            print("INSERT stop statement could not be prepared.")
        }
    }

    func insertMovie(movie: Movie) -> Bool{
        let db = openDatabase()
        defer { sqlite3_finalize(insertStatement) }
        
        let insertStatementString = String(format: "INSERT INTO %@ (movie_id, popularity, vote_count, vote_average, release_date, title, overview, poster_path, backdrop_path, genre_ids, click_amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", SqliteManager.MOVIE_TB)
    
        var result: Bool = false
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(movie.id))
            sqlite3_bind_double(insertStatement, 2, movie.popularity)
            sqlite3_bind_int(insertStatement, 3, Int32(movie.voteCount))
            sqlite3_bind_double(insertStatement, 4, movie.voteAverage)
            sqlite3_bind_text(insertStatement, 5, (movie.releaseDate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (movie.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (movie.overview as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (movie.posterPath as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (movie.backdropPath as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (movie.genreIds.map { String($0) }.joined(separator: ",") as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 11, Int32(movie.clickAmount))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                result = true
            }
            
            if (sqlite3_reset(insertStatement) != SQLITE_OK){
                print("Could not reset row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        
        return result
    }
    
    func queryGenres(withClause clause:String?) -> [Genre] {
        var genres = [Genre]()
        let db = openDatabase()
        defer { sqlite3_finalize(queryStatement) }
        
        var queryStatementStr = String(format: "SELECT * FROM %@;", SqliteManager.GENRE_TB)
        if let whereClause = clause {
            queryStatementStr = String(format: "SELECT * FROM %@ %@;", SqliteManager.GENRE_TB, whereClause)
        }
        
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementStr, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let genreId = sqlite3_column_int(queryStatement, 1)
                let name = String(cString: sqlite3_column_text(queryStatement, 2))

                let genre = Genre()
                genre.id = CLongLong(genreId)
                genre.name = name
                genres.append(genre)
            }
        } else {
            print("SELECT statement could not be prepared")
        }

        return genres
    }
    
    func queryViewHistory() -> [Movie] {
        var movies = [Movie]()
        let db = openDatabase()
        defer { sqlite3_finalize(queryStatement) }
        
        let queryStatementStr = String(format: "SELECT * FROM %@ order by click_amount desc", SqliteManager.MOVIE_TB)

        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementStr, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let movieId = sqlite3_column_int(queryStatement, 1)
                let popularity = sqlite3_column_double(queryStatement, 2)
                let voteCount = sqlite3_column_int(queryStatement, 3)
                let voteAverage = sqlite3_column_double(queryStatement, 4)
                let releaseDate = String(cString: sqlite3_column_text(queryStatement, 5))
                let title = String(cString: sqlite3_column_text(queryStatement, 6))
                let overview = String(cString: sqlite3_column_text(queryStatement, 7))
                let posterPath = String(cString: sqlite3_column_text(queryStatement, 8))
                let backdropPath = String(cString: sqlite3_column_text(queryStatement, 9))
                let genreIds = String(cString: sqlite3_column_text(queryStatement, 10))
                let clickAmount = sqlite3_column_int(queryStatement, 11)

                let movie = Movie()
                movie.id = CLongLong(movieId)
                movie.popularity = popularity
                movie.voteCount  = voteCount
                movie.voteAverage = voteAverage
                movie.releaseDate = releaseDate
                movie.title = title
                movie.overview = overview
                movie.posterPath = posterPath
                movie.backdropPath = backdropPath
                movie.genreIds = genreIds.split(separator: ",").map({ Int32($0)! })
                movie.clickAmount = Int(clickAmount)
                movies.append(movie)
            }
        } else {
            print("SELECT statement could not be prepared")
        }

        return movies
    }
    
    func moviePlus(withMovie movie: Movie){
        let db = openDatabase()
        defer { sqlite3_finalize(updateStatement) }
        
        let updateStatementString = String(format: "UPDATE %@ SET click_amount=%i WHERE movie_id=%i;", SqliteManager.MOVIE_TB, movie.clickAmount, movie.id)

        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) != SQLITE_DONE {
                print("Could not update row.")
            }
        }
    }
    
    func movieViewAmount(withMovie movie: Movie) -> Int{
        let db = openDatabase()
        defer { sqlite3_finalize(queryStatement) }
        
        let queryStatementString = String(format: "SELECT click_amount FROM %@ WHERE movie_id='%i';", SqliteManager.MOVIE_TB, movie.id)

        var clickAmount = 0;
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                clickAmount = Int(sqlite3_column_int(queryStatement, 0))
            }
        }
        
        return clickAmount
    }
}
