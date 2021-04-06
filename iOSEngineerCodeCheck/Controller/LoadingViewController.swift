//
//  LoadingViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/05.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit
import Lottie

final class LoadingViewController: UIViewController {

    @IBOutlet private weak var popupView: UIView!
    @IBOutlet private weak var instructionLabel: UILabel!
    private let animationView = AnimationView(name: "1846-material-activity-indicator")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimationView()
        startAnimating()
        NotificationCenter.default.addObserver(self, selector: #selector(finishAnimating), name: .finishLoading, object: nil)
    }
    
    private func setUpAnimationView(){
        animationView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            animationView.widthAnchor.constraint(equalTo: popupView.widthAnchor),
            animationView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            animationView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20)
        ])
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
    }
    
    private func startAnimating(){
        animationView.play()
    }
    
    @objc private func finishAnimating(){
        self.dismiss(animated: false, completion: nil)
    }
}

extension Notification.Name{
    static let finishLoading = Notification.Name("finishLoading")
}
