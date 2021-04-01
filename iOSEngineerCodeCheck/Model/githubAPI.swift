//
//  SearchModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/01.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

final class githubAPI{
    
    static var contentsArray: [[String: Any]] = []
    
    ///githubAPIにリクエストを投げてリポジトリのデータを取得する
    public func getRepositoryDataOf(_ searchWord:String, completion:@escaping(()->Void)){
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard
                let data = data,
                let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let items = object["items"] as? [[String: Any]]
            else {return}
            githubAPI.contentsArray = items
            DispatchQueue.main.async {
                completion()
            }
        }
        task.resume()
    }
    
    ///avatarImageのURLリクエストを投げてimageのデータを取得する
    public func getAvatarImageOf(_ url: URL, completion:@escaping((UIImage)->Void)){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let image = UIImage(data: data)
            else {return}
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
