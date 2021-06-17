//
//  FriendTableViewCell.swift
//  VKClient
//
//  Created by Кирилл Копытин on 19.05.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var backImageView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup() {
        avatarImageView.layer.cornerRadius = 20
        if let shadowView = backImageView as? BackImageView {
            shadowView.setShadow()
        }
    }
    
    func clearCell() {
        avatarImageView.image = nil
        nameLabel.text = nil
    }
    
    func configure(user: User) {
        nameLabel.text = user.getFullName()
        
        if let avatar = user.avatar {
            avatarImageView.image = avatar
        } else {
            avatarImageView.image = UIImage(named: "camera")
        }
    }
    
    override func prepareForReuse() {
        clearCell()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    @IBAction func onTapAvatar(_ sender: Any) {
        self.backImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.avatarImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.1,
            options: [],
            animations: { [weak self] in
                self?.avatarImageView.transform = .identity
                self?.backImageView.transform = .identity
            },
            completion: nil
        )
    }
}
