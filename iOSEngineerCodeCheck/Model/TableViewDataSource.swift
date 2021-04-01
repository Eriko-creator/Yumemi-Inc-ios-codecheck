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
    
    ///contentsArrayに格納されているrepositoryの数だけセルを返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubAPI.contentsArray.count
    }
    
    ///セルにリポジトリ名、プロジェクト言語を表示する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = githubAPI.contentsArray[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
}
