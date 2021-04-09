//
//  ReadmeViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit
import Alamofire
import MarkdownView

final class ReadmeViewController: UIViewController {
    
    private let md = MarkdownView()
    
    override func loadView() {
        self.view = md
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentReadme()
    }
    
    private func presentReadme(){
        GithubAPI.GetReadmeData.request { (result) in
            switch result{
            case .success(let readme):
                self.getReadme(url: readme.downloadUrl)
            case .failure(let error):
                let label = UILabel(frame: self.view.frame)
                label.center = self.view.center
                label.text = "Readme was not found."
                self.view.addSubview(label)
                print(error)
            }
        }
    }
    
    private func getReadme(url: String){
        guard let url = URL(string: url) else { return }
        AF.request(url).responseString { [unowned self] (response) in
            switch response.result{
            case .success(let string):
                md.load(markdown: string, enableImage: true)
                md.isScrollEnabled = false
            case .failure(let error):
                print(error)
            }
        }
    }
}
