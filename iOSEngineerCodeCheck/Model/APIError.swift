//
//  APIError.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/02.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error{
    case searchWordEmpty
    case invalidURL
    case networkError
    case unknown
    
    var title: String{
        switch self{
        case .networkError:
            return "ネットワークエラー"
        case .unknown:
            return "不明なエラー"
        default:
            return "検索エラー"
        }
    }
    
    var description: String{
        switch self{
        case .searchWordEmpty:
            return "検索ワードを入力してください。"
        case .invalidURL:
            return "別の検索ワードを試してください。検索ワードには半角英数字のみお使いいただけます。"
        case .networkError:
            return "接続環境の良いところでもう一度お試しください。"
        case .unknown:
            return "不明なエラーです。"
        }
    }
}
