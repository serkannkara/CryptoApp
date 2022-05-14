//
//  CryptoListViewController.swift
//  CryptoApp
//
//  Created by Serkan on 5.05.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Alamofire
import Charts


class CryptoListViewController: UIViewController, UIScrollViewDelegate {
    
    var cryptoTableView: UITableView = {
        let cryptTableView = UITableView()
        cryptTableView.rowHeight = 100
        cryptTableView.backgroundColor = .black
        cryptTableView.separatorColor = UIColor.systemGray4.withAlphaComponent(0.2)
        cryptTableView.register(CryptoListCell.self, forCellReuseIdentifier: CryptoListCell.reuseId)
        return cryptTableView
    }()
    
    let activityIndicatorview = UIActivityIndicatorView()
    let viewModel = CryptoListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        setupBinding()
    }
    
    func configureTableView() {
        view.addSubview(cryptoTableView)
        cryptoTableView.frame = view.bounds
    }
    
    func setupBinding(){
        viewModel.loading.asObservable()
            .observe(on: MainScheduler.instance)
            .bind(to: activityIndicatorview.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loadPageTrigger.onNext(())
        
        viewModel.cryptos.bind(to: cryptoTableView.rx.items(cellIdentifier: CryptoListCell.reuseId, cellType: CryptoListCell.self)) { index, item, cell in
            cell.configureCellItems(item: item)
            cell.configureChartView(viewModel: item)
        }.disposed(by: disposeBag)
        
        cryptoTableView.rx.modelSelected(CryptoPresentation.self)
            .subscribe(onNext: { item in
                let destVC = CryptoCoinsListDetailVC()
                destVC.setupUI(item: item)
                self.navigationController?.pushViewController(destVC, animated: true)
            }).disposed(by: disposeBag)
        
        cryptoTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        cryptoTableView.rx.reachedBottom
            .bind(to: viewModel.loadNextPageTrigger)
            .disposed(by: disposeBag)
    }
}
