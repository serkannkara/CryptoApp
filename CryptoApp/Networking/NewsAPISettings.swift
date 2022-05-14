//
//  NewsAPISettings.swift
//  CryptoApp
//
//  Created by Serkan on 13.05.2022.
//

import Foundation


protocol NewsAPISettings {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameterPage: String { get }
    var apiKey: String { get }
    func getNews(page: Int) -> String
}
