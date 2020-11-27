//
//  LoginFormController.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 22.10.2020.
//

import UIKit
import WebKit

class LoginFormController: UIViewController {
    
    private lazy var myToken = Session.instance
    private lazy var myInfo = NetworkService()

    // MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7660270"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.85")]
        
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }

    
    //MARK: - Actions

}

// MARK: - WKNavigationDelegate

extension LoginFormController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        print(params)
        guard let token = params ["access_token"], let userId = Int(params["user_id"]!) else {
            decisionHandler(.cancel)
            return
        }
        print(token, userId)
        myToken.token = token
        myToken.userId = userId
        performSegue(withIdentifier: "LoginOk", sender: nil)
        decisionHandler(.cancel)
    }
}

