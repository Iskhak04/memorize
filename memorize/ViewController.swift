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
    
    var cards: [CardModel] = [CardModel(imageStr: "bolt", isHid: true), CardModel(imageStr: "heart", isHid: true), CardModel(imageStr: "house", isHid: true), CardModel(imageStr: "star", isHid: true), CardModel(imageStr: "star", isHid: true), CardModel(imageStr: "mic.fill", isHid: true), CardModel(imageStr: "house", isHid: true), CardModel(imageStr: "x.squareroot", isHid: true), CardModel(imageStr: "x.squareroot", isHid: true), CardModel(imageStr: "clock.fill", isHid: true), CardModel(imageStr: "cart.fill", isHid: true), CardModel(imageStr: "heart", isHid: true), CardModel(imageStr: "mic.fill", isHid: true), CardModel(imageStr: "clock.fill", isHid: true), CardModel(imageStr: "cart.fill", isHid: true), CardModel(imageStr: "bolt", isHid: true)]
    
    var flipCountLabel = UILabel()
    
    var flipCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
    }

    func layout() {
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
    
    func flipCard(index: IndexPath) {
        var falseArr: [Int] = []
        if cards.filter({$0.isHid == false}).count == 2 {
            flipCount -= 1
        } else {
            cards[index.row].isHid = false
            falseArr.append(index.row)
            if cards.filter({$0.isHid == false}).count == 2 {
                if cards.filter({$0.isHid == false})[0].imageStr == cards.filter({$0.isHid == false})[1].imageStr {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.cards.removeAll(where: {$0.isHid == false})
                        
                        self.grid.reloadData()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        for i in 0..<self.cards.count {
                            self.cards[i].isHid = true
                        }
                        self.grid.reloadData()
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
        cell.cardImage.isHidden = cards[indexPath.row].isHid
        cell.background.isHidden = cards[indexPath.row].isHid
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        flipCard(index: indexPath)
        flipCount += 1
        flipCountLabel.text = "Flips: \(flipCount)"
        
    }
}



