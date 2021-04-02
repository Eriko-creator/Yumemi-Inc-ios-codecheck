//
//  AlertUtility.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/02.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

struct AlertUtility{
    
    static func showAPIErrorAlert(error: APIError, _ viewController: UIViewController){
        let title = error.title
        let message = error.description
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
