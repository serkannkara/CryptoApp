//
//  CryptoPresentation.swift
//  CryptoApp
//
//  Created by Serkan on 10.05.2022.
//

import Foundation


final class CryptoPresentation: NSObject {
    
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let lastUpdate: String
    let priceChange: Double
    let price: [Double]
    
    init(id: String, symbol: String, name: String, image: String, currentPrice: Double, lastUpdate: String, priceChange: Double, price: [Double]){
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.lastUpdate = lastUpdate
        self.priceChange = priceChange
        self.price = price
        super.init()
    }
    
    convenience init(crypto: Cryptos) {
        self.init(id: crypto.id, symbol: crypto.symbol, name: crypto.name, image: crypto.image, currentPrice: crypto.currentPrice, lastUpdate: crypto.lastUpdate, priceChange: crypto.priceChange, price: crypto.sparkline.price)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CryptoPresentation else { return false}
        return self.id == other.id && self.symbol == other.symbol && self.name == other.name && self.image == other.image && self.currentPrice == other.currentPrice && self.lastUpdate == other.lastUpdate && self.priceChange == other.priceChange
    }
}
