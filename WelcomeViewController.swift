//
//  WelcomeViewController.swift
//  memorize
//
//  Created by Iskhak Zhutanov on 23/8/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var numOfSquares = UITextField()
    var startButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
    }

    func layout() {
        view.addSubview(numOfSquares)
        numOfSquares.translatesAutoresizingMaskIntoConstraints = false
        numOfSquares.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        numOfSquares.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        numOfSquares.placeholder = "Number of images(max 10)"
        numOfSquares.heightAnchor.constraint(equalToConstant: 80).isActive = true
        numOfSquares.widthAnchor.constraint(equalToConstant: 240).isActive = true
        numOfSquares.backgroundColor = .cyan
        
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -320).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = startButton.titleLabel?.font.withSize(40)
        startButton.backgroundColor = .blue
        startButton.layer.cornerRadius = 40
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
    }
    
    @objc func start() {
        let gameVC = ViewController()
        if let input = numOfSquares.text {
            if let num = Int(input) {
                if num > gameVC.images.count {
                    
                } else {
                    gameVC.squareCount = num
                    navigationController?.pushViewController(gameVC, animated: true)
                }
            }
        }
    }
}
