//
//  NewsListCell.swift
//  CryptoApp
//
//  Created by Serkan on 11.05.2022.
//

import Foundation
import UIKit


class NewsListCell: UITableViewCell {
    
    static let reusId = "newCryptoCell"
    
    var newsImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.widthAnchor.constraint(equalToConstant: 80).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return iv
    }()
    
    var newsTitle: UILabel = {
        let nwttl = UILabel()
        nwttl.textColor = .white
        nwttl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nwttl.numberOfLines = 3
        return nwttl
    }()
    
    var newsDate: UILabel = {
        let nwttl = UILabel()
        nwttl.textColor = .systemGray
        nwttl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        nwttl.textAlignment = .right
        return nwttl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = .black
    }
    
    private func configure(){
        
        let labelsStackView = UIStackView(arrangedSubviews: [
            newsTitle , newsDate
        ])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [
            newsImageView, labelsStackView
        ])
        stackView.spacing = 10
        stackView.alignment = .center
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
