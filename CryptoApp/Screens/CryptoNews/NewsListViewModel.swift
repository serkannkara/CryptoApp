//
//  NewsListViewModel.swift
//  CryptoApp
//
//  Created by Serkan on 11.05.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class NewsListViewModel {
    
    var newsService: CryptoServiceProtocol
    var page = 2
    let cryptoNews: BehaviorSubject<[CryptoNewsPresentation]> = .init(value: [])
    
    let loading: Observable<Bool>
    var loadPageTrigger: PublishSubject<Void>
    var loadNextPageTrigger: PublishSubject<Void>
    var loadingIndicator: ActivityIndicator!
    
    private let error = PublishSubject<Swift.Error>()
    
    private let disposeBag = DisposeBag()
            
    init(newsService: CryptoServiceProtocol = CryptoService()){
        loadingIndicator = ActivityIndicator()
        loading = loadingIndicator.asObservable()
        loadPageTrigger = PublishSubject()
        loadNextPageTrigger = PublishSubject()
        
        self.newsService = newsService
        
        let firstRequest = self.loading
            .sample(self.loadPageTrigger)
            .flatMap { [weak self] loading -> Observable<[CryptoNewsPresentation]> in
                guard let self = self else { fatalError()}
                if loading {
                    return Observable.empty()
                }else {
                    self.page = 2
                    self.cryptoNews.onNext([])
                    let cryptoNews = self.newsService.fetchCryptoNews(page: self.page).map({ items in items.articles })
                    let mappedCryptoNews = cryptoNews.map({ items in items.map({ item  in CryptoNewsPresentation(cryptoNews: item) }) })                    
                    return mappedCryptoNews
                        .trackActivity(self.loadingIndicator)
                }
            }
        
        let nextRequest = self.loading
            .sample(loadNextPageTrigger)
            .flatMap { [weak self] isLoading -> Observable<[CryptoNewsPresentation]> in
                guard let self = self else { fatalError() }
                if isLoading {
                    return Observable.empty()
                }else {
                    self.page = self.page + 1
                    let cryptoNews = self.newsService.fetchCryptoNews(page: self.page).map({  items in items.articles })
                    let mappedCryptoNews = cryptoNews.map({ items in items.map({ item  in CryptoNewsPresentation(cryptoNews: item) }) })
                    return mappedCryptoNews
                        .trackActivity(self.loadingIndicator)
                }
            }
        
        let request = Observable.of(firstRequest, nextRequest)
            .merge()
            .share(replay: 1)
        
        let response = request
            .flatMapLatest { cryptoNews -> Observable<[CryptoNewsPresentation]> in
                request
                    .do(onError: { _error in
                        self.error.onNext(_error)
                    }).catch({ error -> Observable<[CryptoNewsPresentation]> in
                        Observable.empty()
                    })
            }
            .share(replay: 1)
        
        Observable
            .combineLatest(request, response, cryptoNews.asObservable()) { request, response, cryptoNews in
                return self.page == 2 ? response : cryptoNews + response
            }
            .sample(response)
            .bind(to: cryptoNews)
            .disposed(by: disposeBag)
    }
}
