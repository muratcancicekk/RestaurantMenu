//
//  AlertShowable.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 2.06.2023.
//

import UIKit

protocol AlertShowable {
    func showAlert(message: String)
}

extension AlertShowable where Self: UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Okey", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default))
        self.present(alert, animated: true)
    }
}

