//
//  CryptoNewsPresentation.swift
//  CryptoApp
//
//  Created by Serkan on 11.05.2022.
//

import Foundation


final class CryptoNewsPresentation: NSObject {
    let title: String
    let descriptionn: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    
    init(title: String, description: String, url: String, urlToImage: String, publishedAt: Date){
        self.title = title
        self.descriptionn = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
    convenience init(cryptoNews: CryptoArticles) {
        self.init(title: cryptoNews.title, description: cryptoNews.description, url: cryptoNews.url, urlToImage: cryptoNews.urlToImage, publishedAt: cryptoNews.publishedAt)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CryptoNewsPresentation else { return false }
        return self.title == other.title && self.descriptionn == other.descriptionn && self.url == other.url && self.urlToImage == other.urlToImage && self.publishedAt == other.publishedAt
    }
}
