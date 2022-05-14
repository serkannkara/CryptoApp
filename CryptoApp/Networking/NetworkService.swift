//
//  NetworkService.swift
//  CryptoApp
//
//  Created by Serkan on 5.05.2022.
//

import Foundation
import RxSwift
import Alamofire
import Differentiator



protocol CryptoServiceProtocol {
    func fetchCryptoNews(page: Int) -> Observable<CryptoNews>
    func fetchCryptos(_ page: Int) -> Observable<[Cryptos]>
}


class CryptoService: CryptoServiceProtocol {
    
    func fetchCryptoNews(page: Int) -> Observable<CryptoNews> {
        return request(url: URL(string: NewsAPI.fetchNews.getNews(page: page))!)
    }
    
    func fetchCryptos(_ page: Int) -> Observable<[Cryptos]> {
        return request(url: URL(string: CryptoAPI.fetchCrypto.getCrypto(page))!)
    }
    
    func request<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            AF.request(url).responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let response = try decoder.decode(T.self, from: data)
                        observer.onNext(response)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                
            }
        }
    }
}
