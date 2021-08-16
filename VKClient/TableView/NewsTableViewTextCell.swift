//
//  NewsTableViewTextCell.swift
//  VKClient
//
//  Created by Кирилл Копытин on 13.08.2021.
//

import UIKit

class NewsTableViewTextCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup() {
    }
    
    func clearCell() {
        descriptionLabel.text = nil
    }
    
    func configure(news: FirebaseNew) {
        if let description = news.text {
            descriptionLabel.text = description
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
