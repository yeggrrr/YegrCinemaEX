//
//  UIImageView+.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/27/24.
//

import UIKit

extension UIImageView {
    func setUI(borderColor: CGColor) {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = borderColor
        layer.masksToBounds = true
    }
    
    func VideoUI() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 20
        clipsToBounds = true
    }
}
