//
//  ResultsModel.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 23/01/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit

struct ResultsModel:Decodable {
    var results = [NewsArticlesModel]()
    
    init(results:[NewsArticlesModel]) {
        self.results = results
    }
}

struct NewsArticlesModel:Decodable {
    
    var id :Int?
    var title :String?
    var abstract :String?
    
    var published_date :String?
    let media: [MediaModel]?
    init(id: Int,title:String,media:[MediaModel],published_date:String,abstract:String) {
        self.id = id
        self.title = title
        self.media = media
        self.published_date = published_date
        self.abstract = abstract
    }
}


struct MediaModel:Decodable {
    enum CodingKeys: String, CodingKey {
       case mediaMetadata = "media-metadata"
    }
    var mediaMetadata: [MediaMetaData]
    
}

struct MediaMetaData:Decodable {
    var url :String?
}

