//
//  SearchModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/01.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

final class githubAPI{
    
    ///githubAPIにリクエストを投げてリポジトリのデータを取得する
    public func getRepositoryDataOf(_ searchWord:String, completion:@escaping(()->Void)){
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)") else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            do{
                guard let data = response.data else {return}
                let result = try JSONDecoder().decode(Repository.self, from: data)
                //シングルトンに値を格納する
                let tableViewDatasource = TableViewDataSource.shared
                tableViewDatasource.repositories = result
                DispatchQueue.main.async {
                    completion()
                }
            }catch{
                print(error)
            }
        }
//        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
//            guard
//                let data = data,
//                let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//                let items = object["items"] as? [[String: Any]]
//            else {return}
//            githubAPI.contentsArray = items
//            DispatchQueue.main.async {
//                completion()
//            }
//        }
//        task.resume()
    }
    
    ///avatarImageのURLリクエストを投げてimageのデータを取得する
    public func getAvatarImageOf(_ url: URL, completion:@escaping((UIImage)->Void)){
        AF.request(url).responseJSON { (response) in
            guard let data = response.data,
                  let image = UIImage(data: data)
            else {return}
            completion(image)
        }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data,
//                  let image = UIImage(data: data)
//            else {return}
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        }.resume()
    }
}
