//
//  LoginFormController.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 22.10.2020.
//

import UIKit

class LoginFormController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var loginScroll: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Actions
    
    @IBAction func enterButton(_ sender: Any) {
    }
}

// MARK: - Keyboard methods

private extension LoginFormController {
    @objc
    func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        loginScroll.contentInset = contentInsets
        loginScroll.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        loginScroll.contentInset = contentInsets
        loginScroll.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    func hideKeyboard() {
        loginScroll.endEditing(true)
    }
}

// MARK: - addTargets

private extension LoginFormController {
    func addTargets() {
        loginScroll.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
}
