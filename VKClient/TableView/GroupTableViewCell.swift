//
//  GroupTableViewCell.swift
//  VKClient
//
//  Created by Кирилл Копытин on 19.05.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup() {
    }
    
    func clearCell() {
        avatarImageView.image = nil
        nameLabel.text = nil
    }
    
    func configure(group: Group) {
        nameLabel.text = group.name
        
        if let avatar = group.avatar {
            avatarImageView.image = avatar
        } else {
            avatarImageView.image = UIImage(named: "community")
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
}
