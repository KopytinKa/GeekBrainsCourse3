//
//  NewsTableViewImageCell.swift
//  VKClient
//
//  Created by Кирилл Копытин on 13.08.2021.
//

import UIKit

class NewsTableViewImageCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    func setup() {
    }
    
    func clearCell() {
        photoImageView.image = nil
    }
    
    func configure(news: FirebaseNew) {
        if let image = news.urlImage {
            photoImageView.sd_setImage(with: URL(string: image))
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
