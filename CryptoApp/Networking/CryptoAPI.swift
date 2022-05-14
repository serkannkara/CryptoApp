//
//  CryptoAPI.swift
//  CryptoApp
//
//  Created by Serkan on 13.05.2022.
//

import Foundation


enum CryptoAPI {
    case fetchCrypto
    case searchCrypto
}

extension CryptoAPI: CryptoAPISetting {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.coingecko.com"
    }
    
    var path: String {
        return "/api/v3/"
    }
    
    var parameterPage: String {
        return "coins/markets?vs_currency=usd&order=market_cap_desc&per_page="
    }
    
    var parameterUsername: String {
        return "search?query="
    }
    
    func getCrypto(_ page: Int) -> String{
        return "\(scheme)://\(host)\(path)\(parameterPage)\(page)&sparkline=true&price_change_percentage=24h"
    }
}
