//
//  CryptoListViewModel.swift
//  CryptoApp
//
//  Created by Serkan on 5.05.2022.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
import Differentiator


final class CryptoListViewModel {
    
    var service: CryptoServiceProtocol
    var page = 16
    let cryptos: BehaviorSubject<[CryptoPresentation]> = .init(value: [])
    let loading: Observable<Bool>
    var loadPageTrigger: PublishSubject<Void>
    var loadNextPageTrigger: PublishSubject<Void>
    var loadingIndicator: ActivityIndicator!
    private let error = PublishSubject<Swift.Error>()
    let disposeBag = DisposeBag()
    
    init(service: CryptoServiceProtocol = CryptoService()) {
        loadingIndicator = ActivityIndicator()
        loading = loadingIndicator.asObservable()
        loadPageTrigger = PublishSubject()
        loadNextPageTrigger = PublishSubject()
        self.service = service
        let firstRequest = self.loading
            .sample(self.loadPageTrigger)
            .flatMap { [weak self] loading -> Observable<[CryptoPresentation]> in
                guard let self = self else { fatalError()}
                if loading {
                    return Observable.empty()
                }else {
                    self.page = 16
                    self.cryptos.onNext([])
                    let cryptos = self.service.fetchCryptos(self.page).map({ items in items.self })
                    let mappedCryptos = cryptos.map({ items in items.map({ item  in CryptoPresentation.init(crypto: item) })  })
                    return mappedCryptos
                        .trackActivity(self.loadingIndicator)
                }
            }
        
        let nextRequest = self.loading
            .sample(loadNextPageTrigger)
            .flatMap { [weak self] isLoading -> Observable<[CryptoPresentation]> in
                guard let self = self else { fatalError() }
                if isLoading {
                    return Observable.empty()
                }else {
                    self.page = self.page + 10
                    let cryptos = self.service.fetchCryptos(self.page).map({ items in items.self })
                    let mappedCryptos = cryptos.map({ items in items.map({ item  in CryptoPresentation.init(crypto: item) }) })
                    return mappedCryptos
                        .trackActivity(self.loadingIndicator)
                }
            }
        
        let request = Observable.of(firstRequest, nextRequest)
            .merge()
            .share(replay: 1)
        
        let response = request
            .flatMapLatest { cryptos -> Observable<[CryptoPresentation]> in
                request
                    .do(onError: { _error in
                        self.error.onNext(_error)
                    }).catch({ error -> Observable<[CryptoPresentation]> in
                        Observable.empty()
                    })
            }
            .share(replay: 1)
        
        Observable
            .combineLatest(request, response, cryptos.asObservable()) { request, response, cryptos in
                return self.page == 15 ? cryptos + response : response
            }
            .sample(response)
            .bind(to: cryptos)
            .disposed(by: disposeBag)
    }
}
