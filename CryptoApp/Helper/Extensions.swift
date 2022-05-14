//
//  Extensions.swift
//  CryptoApp
//
//  Created by Serkan on 11.05.2022.
//

import Foundation
import RxSwift


extension Reactive where Base: UIScrollView {
    public var reachedBottom: Observable<Void> {
        let scrollView = self.base as UIScrollView
        return self.contentOffset.flatMap{ [weak scrollView] (contentOffset) -> Observable<Void> in
            guard let scrollView = scrollView else { return Observable.empty() }
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            let threshold = max(0.0, contentHeight - height)

            return (offsetY > threshold) ? Observable.just(()) : Observable.empty()
        }
    }
}
