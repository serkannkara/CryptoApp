//
//  Cryptos.swift
//  CryptoApp
//
//  Created by Serkan on 5.05.2022.
//

import Foundation


struct Cryptos: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let lastUpdate: String
    let priceChange: Double
    let sparkline: Sparkline
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case lastUpdate = "last_updated"
        case priceChange = "price_change_24h"
        case sparkline = "sparkline_in_7d"
       
        
    }
}

struct Sparkline: Decodable {
    let price: [Double]
    enum CodingKeys: String, CodingKey {
        case price
    }
}
