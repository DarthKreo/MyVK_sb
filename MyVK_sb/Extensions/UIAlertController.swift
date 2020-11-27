//
//  UIAlertController.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 24.11.2020.
//

import UIKit

extension UIViewController {
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
