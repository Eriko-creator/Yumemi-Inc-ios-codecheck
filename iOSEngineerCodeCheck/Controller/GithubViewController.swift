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
        let storyboard = UIStoryboard(name: "LoadingView", bundle: nil)
        guard let load = storyboard.instantiateViewController(identifier: "load") as? LoadingViewController else { return }
        self.present(load, animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NotificationCenter.default.post(name: .finishLoading, object: nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NotificationCenter.default.post(name: .finishLoading, object: nil)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NotificationCenter.default.post(name: .finishLoading, object: nil)
    }
}
