//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var avatorImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsCount: UILabel!
    @IBOutlet private weak var watchersCount: UILabel!
    @IBOutlet private weak var forksCount: UILabel!
    @IBOutlet private weak var issuesCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView(){
        ///searchViewControllerで取得したrepositoryの内容を反映させる
        let tableViewDataSource = TableViewDataSource.shared
        let repository = tableViewDataSource.repositories.items[tableViewDataSource.selectedIndex]
        languageLabel.text = "Written in \(repository.language)"
        starsCount.text = "\(repository.stargazersCount) stars"
        watchersCount.text = "\(repository.watchersCount) watchers"
        forksCount.text = "\(repository.forksCount) forks"
        issuesCount.text = "\(repository.openIssuesCount) open issues"
        titleLabel.text = repository.fullName
        guard let url = URL(string: repository.owner.avatarUrl) else {return}
        setImage(from: url)
    }
    
    ///searchViewControllerで取得したrepository内のURLからavatorImageViewを取得して反映させる
    private func setImage(from url: URL){
        let github = githubAPI()
        github.getAvatarImageOf(url){ (image) in
            self.avatorImageView.image = image
        }
    }
}
