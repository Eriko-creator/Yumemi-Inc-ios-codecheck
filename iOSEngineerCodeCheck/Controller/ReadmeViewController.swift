//
//  ReadmeViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit
import MarkdownView

final class ReadmeViewController: UIViewController {
    
    private let md = MarkdownView()
    
    override func loadView() {
        self.view = md
        self.view.translatesAutoresizingMaskIntoConstraints = false
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
                self.showLabel()
                self.didFinishLoading()
                print(error)
            }
        }
    }
    
    private func getReadme(url: String){
        guard let url = URL(string: url) else { return }
        DefaultURLRequest.shared.requestString(url: url) { (string) in
            self.md.load(markdown: string, enableImage: true)
            self.setUpMarkdownView()
        }
    }
    
    private func showLabel(){
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 30)))
        label.text = "Readme was not found."
        label.font = .systemFont(ofSize: 15.0)
        self.view.addSubview(label)
    }
    
    private func setUpMarkdownView(){
        md.isScrollEnabled = false
        md.onRendered = { [weak self] height in
            self?.view.frame.size.height = height
            self?.view.setNeedsLayout()
            self?.didFinishLoading()
        }
    }
    
    ///DetailViewのActivityIndicatorを消すメソッド
    private func didFinishLoading(){
        guard let parent = self.parent as? DetailViewController else { return }
        parent.activityIndicator.isHidden = true
    }
}
