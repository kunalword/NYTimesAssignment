//
//  Webservice.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 23/01/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit

class Webservice:NSObject {
     
    static let shareInstance = Webservice()

    
   func getNewsArticlesData(completion: @escaping ([NewsArticlesModel]?, Error?) -> ()) {
    
    
        let isConnect = InternetHandlerClass.isConnectedToNetwork()
        print(isConnect)
        if isConnect {
            
            guard let url = URL(string: UrlConstants.baseURL + UrlConstants.baseUrlKey) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let err = error {
                    print("Loading data error:",err.localizedDescription)
                } else {
                    
                    guard let data = data else { return }
                    do {
                        var arrNewsData = [NewsArticlesModel]()
                        let results = try JSONDecoder().decode(ResultsModel.self, from: data)
                        
                        for news in results.results {
                            arrNewsData.append(NewsArticlesModel(id: news.id!, title: news.title!, media: news.media!, published_date: news.published_date!, abstract: news.abstract!))
                        }
                        completion(arrNewsData,nil)
                        
                    } catch let jsonErr {
                        print("Json error",jsonErr.localizedDescription)
                    }
                    
                }
                
                
            }.resume()
            
            
        }
        
    }
    
    
    
}

