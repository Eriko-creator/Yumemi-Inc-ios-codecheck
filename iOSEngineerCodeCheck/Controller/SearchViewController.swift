//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.dataSource = dataSource
            tableView.delegate = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.text = "GitHubのリポジトリを検索できるよー"
            searchBar.delegate = self
        }
    }
    
    private let github = githubAPI()
    private var dataSource = TableViewDataSource()
    var task: URLSessionTask?
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: UISearchBarDelegate{
    
    ///searchBarをタップした際にテキストを空にする
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    ///入力文字が変更された時はAPI通信をしない
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let task = task else {return}
        task.cancel()
    }
    
    ///searchボタンがタップされた時に入力文字を用いてgitHubAPIにリクエストを投げ、
    ///tableViewをリロードして反映させる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text,
              !searchWord.isEmpty
        else {return}
        github.getRepositoryDataOf(searchWord) {
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDelegate{
    
    ///選択したセルのindexPath.row番目の数字をselectedIndexに格納する
    ///DetailViewControllerに画面遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        guard let detail = storyboard.instantiateViewController(identifier: "detail") as? DetailViewController else { return }
        detail.searchViewController = self
        navigationController?.pushViewController(detail, animated: true)
    }
}
