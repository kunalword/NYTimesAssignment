//
//  NewsListViewModel.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 23/01/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import Foundation

class NewsListViewModel: NSObject {
    var id :Int?
    var title :String?
    var abstract :String?
    var media :[MediaModel]?
    var published_date :String?
    
    init(news:NewsArticlesModel) {
        self.id = news.id
        self.title = news.title
        self.abstract = news.abstract
        self.media = news.media
        self.published_date = news.published_date
    }
    
}
