//
//  VKAuthViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 18.06.2021.
//
import UIKit
import WebKit
import SwiftKeychainWrapper
import FirebaseDatabase

class VKAuthViewController: UIViewController {

    @IBOutlet weak var authVKWebView: WKWebView! {
        didSet {
            authVKWebView.navigationDelegate = self
        }
    }
    
    let fromAuthVKToLoginViewSegueIdentifier = "fromAuthVKToLoginView"
    
    private let ref = Database.database().reference(withPath: "users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oauthAuthorizationToVK()
    }
    
    func oauthAuthorizationToVK() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7883036"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "response_type", value: "token"),
        ]
        
        let request = URLRequest(url: urlComponents.url!)
                
        authVKWebView.load(request)
    }
}

extension VKAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = params["access_token"], let userId = params["user_id"] else {
            decisionHandler(.allow)
            return
        }
        
        KeychainWrapper.standard.set(token, forKey: "token")
        Session.shared.token = token
        
        UserDefaults.standard.set(userId, forKey: "userId")
        Session.shared.userId = userId
        
        let user = FirebaseUser(id: userId)
        let userRef = self.ref.child(userId)
        userRef.setValue(user.toAnyObject())
        
        showLoginView()
        
        decisionHandler(.cancel)
    }
    
    func showLoginView() {
        performSegue(withIdentifier: fromAuthVKToLoginViewSegueIdentifier, sender: nil)
    }

}
