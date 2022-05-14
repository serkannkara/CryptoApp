//
//  CryptoAPISettings.swift
//  CryptoApp
//
//  Created by Serkan on 13.05.2022.
//

import Foundation


protocol CryptoAPISetting {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameterPage: String { get }
    var parameterUsername: String { get }
    func getCrypto(_ page: Int) -> String
}
