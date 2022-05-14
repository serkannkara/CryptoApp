//
//  UIHelper.swift
//  CryptoApp
//
//  Created by Serkan on 12.05.2022.
//

import Foundation
import UIKit


struct UIHelper {
    static func collectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        
        let flowLayout = UICollectionViewFlowLayout()
        let itemWidth = view.bounds.width
        let itemHeight : CGFloat = 250
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        return flowLayout
    }
}
