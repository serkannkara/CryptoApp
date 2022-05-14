//
//  CryptoCoinsListDetailVC.swift
//  CryptoApp
//
//  Created by Serkan on 13.05.2022.
//

import Foundation
import UIKit
import Charts


class CryptoCoinsListDetailVC: UIViewController {

    var cryptoImageView: UIImageView = {
        let iv = UIImageView()
        iv.heightAnchor.constraint(equalToConstant: 90).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 90).isActive = true
        iv.clipsToBounds = true
        return iv
    }()
    
    var nameLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.textColor = .white
        nLabel.adjustsFontSizeToFitWidth = true
        nLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return nLabel
    }()
    
    var symbolLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.textColor = .systemGray
        nLabel.adjustsFontSizeToFitWidth = true
        nLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return nLabel
    }()
    
    
    let chartView: LineChartView = {
        let chartV = LineChartView()
        chartV.pinchZoomEnabled = false
        chartV.setScaleEnabled(true)
        chartV.xAxis.enabled = false
        chartV.drawGridBackgroundEnabled = false
        chartV.leftAxis.enabled = false
        chartV.rightAxis.enabled = false
        chartV.contentMode = .center
        return chartV
    }()
    
    var currentPriceLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.textColor = .white
        nLabel.textAlignment = .right
        nLabel.adjustsFontSizeToFitWidth = true
        nLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return nLabel
    }()
    
    var priceChangeLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.textAlignment = .right
        nLabel.adjustsFontSizeToFitWidth = true
        nLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return nLabel
    }()
    
    var sellButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sell Now", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        return button
    }()
    
    var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buy Now", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        return button
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureDetailVC()
    }
    
    func configureChartView(viewModel: CryptoPresentation){
        var entries = [ChartDataEntry]()
        
        for (index, value) in viewModel.price.enumerated() {
            entries.append(.init(x: Double(index), y: value))
        }
        let dataSet = LineChartDataSet(entries: entries, label: "Crypto Coins")
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        if viewModel.priceChange < 0 {
            dataSet.fillColor = .red
        }else {
            dataSet.fillColor = .green
        }
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
    
    func configureDetailVC(){
        
        let namesStackView = UIStackView(arrangedSubviews: [
            nameLabel, symbolLabel
        ])
        namesStackView.axis = .vertical
        namesStackView.contentMode = .center
        
        let priceStackView = UIStackView(arrangedSubviews: [
            currentPriceLabel, priceChangeLabel
        ])
        priceStackView.axis = .vertical
        priceStackView.contentMode = .center
        
        let itemsStackView = UIStackView(arrangedSubviews: [
            cryptoImageView, namesStackView, priceStackView
        ])
        itemsStackView.spacing = 10
        
        let buttonStackView = UIStackView(arrangedSubviews: [
            sellButton, buyButton
        ])
        buttonStackView.spacing = 10
        
        view.addSubview(itemsStackView)
        view.addSubview(chartView)
        view.addSubview(buttonStackView)
        itemsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            itemsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemsStackView.heightAnchor.constraint(equalToConstant: 90),

            chartView.topAnchor.constraint(equalTo: itemsStackView.bottomAnchor, constant: 10),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
            
            buttonStackView.heightAnchor.constraint(equalToConstant: 60),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            sellButton.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            sellButton.trailingAnchor.constraint(equalTo: buttonStackView.centerXAnchor,constant: -5),
            buyButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor),
            buyButton.leadingAnchor.constraint(equalTo: buttonStackView.centerXAnchor,constant: 5),
        ])
    }
}


extension CryptoCoinsListDetailVC {
    func setupUI(item: CryptoPresentation) {
        title = "Currency"
        nameLabel.text = item.name
        symbolLabel.text = item.symbol
        if item.priceChange > 0 {
            priceChangeLabel.textColor = .green
            priceChangeLabel.text = "+\(String(format: "%.2f", item.priceChange))"
        }else {
            priceChangeLabel.textColor = .red
            priceChangeLabel.text = "\(String(format: "%.2f", item.priceChange))"
        }
        currentPriceLabel.text = "$\(item.currentPrice)"
        cryptoImageView.setImage(imageUrl: item.image)
        configureChartView(viewModel: item)
    }
}
