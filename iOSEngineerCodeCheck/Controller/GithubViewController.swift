//
//  GithubViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/04.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit
import WebKit

final class GithubViewController: UIViewController {
    
    private let githubView = WKWebView(frame: .zero)
    private let load = LoadingViewController.makeFromStoryboard()
    
    override func loadView() {
        self.view = githubView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showGithubPage()
        githubView.navigationDelegate = self
    }
    
    private func showGithubPage(){
        let datasource = TableViewDataSource.shared
        let repository = datasource.repositories.items[datasource.selectedIndex]
        guard let url = URL(string: repository.htmlUrl) else { return }
        self.githubView.load(URLRequest(url: url))
    }
}

extension GithubViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.present(load, animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        load.dismiss(animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        load.dismiss(animated: false) {
            UIAlertController.showAPIErrorAlert(error: .unknown, self)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        load.dismiss(animated: false) {
            UIAlertController.showAPIErrorAlert(error: .networkError, self)
        }
    }
}
