//
//  TeamWebSiteVC.swift
//  Football-League
//
//  Created by Tk on 04/11/2020.
//

import UIKit
import WebKit
class TeamWebSiteVC: UIViewController, WKNavigationDelegate {
    var activity: UIActivityIndicatorView!
    var webView: WKWebView!
    var teamURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        guard let url = URL(string: teamURL) else { return }
        webView = WKWebView(frame: self.view.frame)
       
        activity = UIActivityIndicatorView(frame: self.webView.frame)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isUserInteractionEnabled = true
        webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        let request = URLRequest(url: url)
        webView.load(request)

        // add activity
        self.webView.addSubview(self.activity)
        activity.style = .large
        self.activity.startAnimating()
        self.webView.navigationDelegate = self
      
       }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
        self.activity.hidesWhenStopped = true
    }
   
}
