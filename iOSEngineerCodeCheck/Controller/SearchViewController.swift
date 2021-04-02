//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController{
    
    @IBOutlet private weak var tableView: UITableView!{
        didSet{
            tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.dataSource = dataSource
            tableView.delegate = self
        }
    }
    @IBOutlet private weak var searchBar: UISearchBar!{
        didSet{
            searchBar.text = "GitHubのリポジトリを検索できるよー"
            searchBar.delegate = self
        }
    }
    
    private var dataSource = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func getRepositoryData(searchWord: String){
        do{
            try GithubAPI.getRepositoryDataOf(searchWord){ [unowned self] (result) in
                switch result{
                case .success(()):
                    tableView.reloadData()
                case .failure(let error):
                    if error == .networkError{
                        UIAlertController.showAPIErrorAlert(error: .networkError, self)
                    }else{
                        UIAlertController.showAPIErrorAlert(error: .unknown, self)
                    }
                }
            }
        }catch APIError.invalidURL{
            UIAlertController.showAPIErrorAlert(error: .invalidURL, self)
        }catch{
            UIAlertController.showAPIErrorAlert(error: .unknown, self)
        }
    }
}

extension SearchViewController: UISearchBarDelegate{
    
    ///searchBarをタップした際にテキストを空にする
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    ///searchボタンがタップされた時に入力文字を用いてgitHubAPIにリクエストを投げ、
    ///tableViewをリロードして反映させる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text,
              !searchWord.isEmpty
        else { return UIAlertController.showAPIErrorAlert(error: .searchWordEmpty, self) }
        getRepositoryData(searchWord: searchWord)
    }
}

extension SearchViewController: UITableViewDelegate{
    
    ///選択したセルのindexPath.row番目の数字をシングルトンに格納する
    ///DetailViewControllerに画面遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TableViewDataSource.shared.selectedIndex = indexPath.row
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        guard let detail = storyboard.instantiateViewController(identifier: "detail") as? DetailViewController else { return }
        navigationController?.pushViewController(detail, animated: true)
    }
}
