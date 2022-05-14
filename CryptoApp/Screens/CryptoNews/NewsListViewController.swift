//
//  NewsListViewController.swift
//  CryptoApp
//
//  Created by Serkan on 6.05.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SafariServices

class NewsListViewController: UIViewController, UIScrollViewDelegate {
    
    var newsTableView: UITableView = {
        let tblView = UITableView()
        tblView.backgroundColor = .black
        tblView.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.reusId)
        tblView.rowHeight = 100
        return tblView
    }()
    
    let activityIndicatorView = UIActivityIndicatorView()
    private let disposeBag = DisposeBag()
    let viewModel = NewsListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configurTablView()
        setupBindingNews()
        view.addSubview(activityIndicatorView)
    }
    
    private func configurTablView(){
        view.addSubview(newsTableView)
        newsTableView.frame = view.bounds
    }
    
    func setupBindingNews(){
        viewModel.loading.asObservable()
            .observe(on: MainScheduler.instance)
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loadPageTrigger.onNext(())
        
        viewModel.cryptoNews.bind(to: newsTableView.rx.items(cellIdentifier: NewsListCell.reusId, cellType: NewsListCell.self)) { index, item, cell in
            cell.newsImageView.setImage(imageUrl: item.urlToImage)
            cell.newsTitle.text = item.title
            cell.newsDate.text = item.publishedAt.convertToMonthYearFormat()
        }.disposed(by: disposeBag)
        
        newsTableView.rx.modelSelected(CryptoNewsPresentation.self)
            .subscribe(onNext: { [weak self] news in
                guard let self = self else { return }
                let safariVC = SFSafariViewController(url: URL(string: news.url)!)
                safariVC.preferredBarTintColor = .black
                safariVC.preferredControlTintColor = .white
                self.present(safariVC, animated: true)
            }).disposed(by: disposeBag)
        
        newsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        newsTableView.rx.reachedBottom
            .bind(to: viewModel.loadNextPageTrigger)
            .disposed(by: disposeBag)
    }
}
