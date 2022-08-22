import UIKit

class CardCell: UICollectionViewCell {
    var cardImage = UIImageView()
    var background = UIView()
    
    func fillCards(model: CardModel) {
        cardImage.image = UIImage(systemName: model.imageStr)
    }
    
    override func layoutSubviews() {
        addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        background.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        background.backgroundColor = .white
        background.heightAnchor.constraint(equalToConstant: 85).isActive = true
        background.widthAnchor.constraint(equalToConstant: 85).isActive = true
        background.layer.cornerRadius = 17
        
        addSubview(cardImage)
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        cardImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        cardImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
}
