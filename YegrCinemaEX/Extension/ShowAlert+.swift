//
//  ShowAlert+.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/26/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
