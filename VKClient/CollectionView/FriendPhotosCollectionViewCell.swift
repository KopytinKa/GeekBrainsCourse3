//
//  FriendPhotosCollectionViewCell.swift
//  VKClient
//
//  Created by Кирилл Копытин on 19.05.2021.
//

import UIKit

class FriendPhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var friendPhotoImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var isTap = false
    
    func setup() {
        friendPhotoImageView.alpha = 0
        friendPhotoImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    func clearCell() {
        friendPhotoImageView.image = nil
        heartImageView.image = UIImage(systemName: "heart")
        countLabel.text = "34"
    }
    
    func configure(photo: UIImage?) {
        if let photo = photo {
            friendPhotoImageView.image = photo
        }
        likeButton.addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    @objc func onTap() {
        if isTap {
            heartImageView.image = UIImage(systemName: "heart")
            animateChangeCountTo(String(Int(countLabel.text!)! - 1))
            isTap = false
        } else {
            heartImageView.image = UIImage(systemName: "heart.fill")
            animateChangeCountTo(String(Int(countLabel.text!)! + 1))
            isTap = true
        }
    }
    
    func animateChangeCountTo(_ count: String) {
        UIView.transition(
            with: self.countLabel,
            duration: 0.5,
            options: .transitionFlipFromRight,
            animations: { [weak self] in
                self?.countLabel.text = count
            },
            completion: nil
        )
    }
    
    func showPhotoWithAnimate() {
        UIView.animate(
            withDuration: 1.25,
            animations: { [weak self] in
                self?.friendPhotoImageView.transform = .identity
                self?.friendPhotoImageView.alpha = 1
            }
        )
    }
    
    override func prepareForReuse() {
        clearCell()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
        showPhotoWithAnimate()
    }
}
