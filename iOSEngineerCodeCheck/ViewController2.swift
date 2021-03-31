//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var avatorImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var watchersCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var issuesCount: UILabel!
    
    var vc1: ViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = vc1.contentsArray[vc1.selectedIndex]
        
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsCount.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersCount.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksCount.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesCount.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let repository = vc1.contentsArray[vc1.selectedIndex]
        
        titleLabel.text = repository["full_name"] as? String
        
        if let owner = repository["owner"] as? [String: Any] {
            if let imageURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, response, error) in
                    let image = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.avatorImageView.image = image
                    }
                }.resume()
            }
        }
        
    }
    
}
