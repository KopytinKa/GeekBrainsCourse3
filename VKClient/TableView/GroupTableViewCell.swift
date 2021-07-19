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
    
    func configure(group: GroupModel) {
        nameLabel.text = group.name
        avatarImageView.sd_setImage(with: URL(string: group.avatar), placeholderImage: UIImage(named: "community"))
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
