//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contentsArray: [[String: Any]]=[]
    var task: URLSessionTask?
    var searchWord: String!
    var url: String!
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    ///searchBarをタップした際にテキストを空にする
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    ///入力文字が変更された時はAPI通信をしない
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    ///searchボタンがタップされた時に入力文字を用いてgitHubAPIにリクエストを投げ、
    ///tableViewをリロードして反映させる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchWord = searchBar.text!
        guard searchWord != nil else {return}
        url = "https://api.github.com/search/repositories?q=\(searchWord!)"
        task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            guard
                let object = try! JSONSerialization.jsonObject(with: data!) as? [String: Any],
                let items = object["items"] as? [[String: Any]]
            else {return}
            self.contentsArray = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task?.resume()
    }
    
    ///自身をdetailViewControllerに渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let detail = segue.destination as! DetailViewController
            detail.searchViewController = self
        }
    }
    
    ///contentsArrayに格納されているrepositoryの数だけセルを返す
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsArray.count
    }
    
    ///セルにリポジトリ名、プロジェクト言語を表示する
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = contentsArray[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    ///選択したセルのindexPath.row番目の数字をselectedIndexに格納する
    ///DetailViewControllerに画面遷移する
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
