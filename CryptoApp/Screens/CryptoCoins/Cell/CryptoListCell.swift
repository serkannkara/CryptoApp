//
//  CryptoListCell.swift
//  CryptoApp
//
//  Created by Serkan on 5.05.2022.
//

import Foundation
import UIKit
import Charts


class CryptoListCell: UITableViewCell {
    
    static let reuseId = "cryptoListCell"
    
    var nameLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.textColor = .white
        nLabel.adjustsFontSizeToFitWidth = true
        nLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return nLabel
    }()
    
    var symbolLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.textColor = .systemGray
        nLabel.adjustsFontSizeToFitWidth = true
        nLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return nLabel
    }()
    
    var imageview: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.clipsToBounds = true
        return iv
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
        chartV.heightAnchor.constraint(equalToConstant: 65).isActive = true
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

        nLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return nLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = .black
    }
    
    func configureCellItems(item: CryptoPresentation) {
        nameLabel.text = item.name
        symbolLabel.text = item.symbol
        currentPriceLabel.text = "$\(item.currentPrice)"
        if item.priceChange > 0 {
            priceChangeLabel.textColor = .green
            priceChangeLabel.text = "+\(String(format: "%.2f", item.priceChange))"
        }else {
            priceChangeLabel.textColor = .red
            priceChangeLabel.text = "\(String(format: "%.2f", item.priceChange))"
        }
        imageview.setImage(imageUrl: item.image)
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
    
    private func configureStackView(){
        let namesStackView = UIStackView(arrangedSubviews: [
            nameLabel, symbolLabel
        ])
        namesStackView.axis = .vertical
        namesStackView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        let priceStackView = UIStackView(arrangedSubviews: [
            currentPriceLabel, priceChangeLabel
        ])
        priceStackView.axis = .vertical
        priceStackView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        let chartStackView = UIStackView(arrangedSubviews: [
            chartView
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            imageview, namesStackView, chartStackView, priceStackView
        ])
        stackView.spacing = 10
        stackView.alignment = .center
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        chartView.leadingAnchor.constraint(equalTo: chartStackView.leadingAnchor).isActive = true
        chartView.trailingAnchor.constraint(equalTo: chartStackView.trailingAnchor).isActive = true
    }
}
