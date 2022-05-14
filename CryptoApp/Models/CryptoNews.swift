//
//  CryptoNews.swift
//  CryptoApp
//
//  Created by Serkan on 11.05.2022.
//

import Foundation


struct CryptoNews: Decodable {
    let articles: [CryptoArticles]
}


struct CryptoArticles: Decodable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
}
