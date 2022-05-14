//
//  NewsAPI.swift
//  CryptoApp
//
//  Created by Serkan on 13.05.2022.
//

import Foundation


enum NewsAPI {
    case fetchNews
}


extension NewsAPI: NewsAPISettings {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "newsapi.org"
    }
    
    var path: String {
        return "/v2/"
    }
    
    var parameterPage: String {
        return "everything?q=bitcoin&sortBy=popularity&page="
    }
    
    var apiKey: String {
        return "&apiKey=64e79656aaf345428ffdaed1015a2dd9"
    }
    
    func getNews(page: Int) -> String {
        return "\(scheme)://\(host)\(path)\(parameterPage)\(page)\(apiKey)"
    }
}
