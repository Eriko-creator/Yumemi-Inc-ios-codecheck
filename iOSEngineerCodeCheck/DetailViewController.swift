//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var watchersCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var issuesCount: UILabel!
    
    var searchViewController: SearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///searchViewControllerで取得したrepositoryの内容を反映させる
        let repository = searchViewController.contentsArray[searchViewController.selectedIndex]
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsCount.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersCount.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksCount.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesCount.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }
    
    ///searchViewControllerで取得したrepository内のURLからavatorImageViewを取得して反映させる
    func getImage(){
        let repository = searchViewController.contentsArray[searchViewController.selectedIndex]
        titleLabel.text = repository["full_name"] as? String
        guard let owner = repository["owner"] as? [String: Any],
              let imageURL = owner["avatar_url"] as? String,
              let url = URL(string: imageURL)
        else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let image = UIImage(data: data)
            else {return}
            DispatchQueue.main.async {
                self.avatorImageView.image = image
            }
        }.resume()
    }
}
