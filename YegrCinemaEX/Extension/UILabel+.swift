//
//  UILabel+.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import UIKit

extension UILabel {
    func setUI(aligment: NSTextAlignment, lbTextColor: UIColor, fontStyle: UIFont) {
        textAlignment = aligment
        textColor = lbTextColor
        font = fontStyle
    }
    
    func detailUI(txt: String, txtAlignment: NSTextAlignment, fontStyle: UIFont) {
        text = txt
        textColor = .white
        textAlignment = txtAlignment
        font = fontStyle
        numberOfLines = 0
    }
}
