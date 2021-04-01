//
//  TableViewDataSource.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/01.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

final class TableViewDataSource: NSObject, UITableViewDataSource{
    
    ///シングルトンを作成
    lazy var repositories = Repository(items: [])
    lazy var selectedIndex: Int = 0
    static let shared = TableViewDataSource()
    
    ///contentsArrayに格納されているrepositoryの数だけセルを返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = TableViewDataSource.shared.repositories.items
        return items.count
    }
    
    ///セルにリポジトリ名、プロジェクト言語を表示する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repository = TableViewDataSource.shared.repositories.items[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language
        return cell
    }
}
