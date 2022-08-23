//
//  ViewController.swift
//  memorize
//
//  Created by Iskhak Zhutanov on 22/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var grid: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(CardCell.self, forCellWithReuseIdentifier: "card-cell")
        return view
    }()
    
    var cards: [CardModel] = []
    
    var images = ["bolt", "star", "heart", "house", "clock.fill", "x.squareroot", "figure.walk", "lightbulb.fill", "moon.fill", "lock.fill"]
    
    var flipCountLabel = UILabel()
    
    var flipCount = 0
    
    var squareCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
    }

    func layout() {
        view.backgroundColor = .white
        
        images.shuffle()
        
        for i in 0..<squareCount {
            cards.append(CardModel(imageStr: images[i], isHid: true, isRemoved: false))
        }
        images.shuffle()
        for i in 0..<squareCount {
            cards.append(CardModel(imageStr: images[i], isHid: true, isRemoved: false))
        }
        
        cards.shuffle()
        
        view.addSubview(grid)
        grid.translatesAutoresizingMaskIntoConstraints = false
        grid.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        grid.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        grid.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        grid.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        
        view.addSubview(flipCountLabel)
        flipCountLabel.translatesAutoresizingMaskIntoConstraints = false
        flipCountLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        flipCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        flipCountLabel.text = "Flips: \(flipCount)"
        flipCountLabel.font = flipCountLabel.font.withSize(50)
    }
    
    var falseArr: [Int] = []
    
    func flipCard(index: IndexPath) {
        if cards.filter({$0.isHid == false}).count - cards.filter({$0.isRemoved == true}).count == 2 {
            ()
        } else {
            cards[index.row].isHid = false
            if cards[index.row].isRemoved == false {
                falseArr.append(index.row)
                flipCount += 1
            }
            
            if falseArr.count >= 2 {
                if cards[falseArr[0]].imageStr == cards[falseArr[1]].imageStr {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.cards[self.falseArr[0]].isRemoved = true
                        self.cards[self.falseArr[1]].isRemoved = true
                        self.grid.reloadData()
                        self.falseArr = []
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.cards[self.falseArr[0]].isHid = true
                        self.cards[self.falseArr[1]].isHid = true
                        self.grid.reloadData()
                        self.falseArr = []
                    }
                }
            }
            grid.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = grid.dequeueReusableCell(withReuseIdentifier: "card-cell", for: indexPath) as! CardCell
        cell.fillCards(model: cards[indexPath.row])
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 20
        if cards[indexPath.row].isRemoved {
            cell.backgroundColor = .white
            cell.cardImage.isHidden = true
        } else {
            cell.cardImage.isHidden = cards[indexPath.row].isHid
            cell.background.isHidden = cards[indexPath.row].isHid
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        flipCard(index: indexPath)
        flipCountLabel.text = "Flips: \(flipCount)"
    }
}



