//
//  UIImageView+Ext.swift
//  CryptoApp
//
//  Created by Serkan on 5.05.2022.
//

import Foundation
import UIKit
import Kingfisher


extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
