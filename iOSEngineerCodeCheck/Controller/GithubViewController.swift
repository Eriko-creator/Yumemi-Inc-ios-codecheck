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
    }
    
    private func showGithubPage(){
        let datasource = TableViewDataSource.shared
        let repository = datasource.repositories.items[datasource.selectedIndex]
        guard let url = URL(string: repository.htmlUrl) else { return }
        self.githubView.load(URLRequest(url: url))
    }
}
