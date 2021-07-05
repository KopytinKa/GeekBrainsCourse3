//
//  NewsTableViewCell.swift
//  VKClient
//
//  Created by Кирилл Копытин on 31.05.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var likeFlag = false
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var countLikesLabel: UILabel!
    @IBOutlet weak var countCommentsLabel: UILabel!
    @IBOutlet weak var countRepostsLabel: UILabel!
    @IBOutlet weak var countViewsLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func tapLikeButton(_ sender: Any) {
        if likeFlag {
            likeFlag = false
            countLikesLabel.text = String(Int(countLikesLabel.text!)! - 1)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            likeFlag = true
            countLikesLabel.text = String(Int(countLikesLabel.text!)! + 1)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    func setup() {
    }
    
    func clearCell() {
        descriptionLabel.text = nil
        photoImageView.image = nil
        countLikesLabel.text = "0"
        countViewsLabel.text = "4,5K"
        countRepostsLabel.text = "999"
        countCommentsLabel.text = "999"
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeFlag = false
    }
    
    func configure(news: News) {
        if let image = news.photo {
            photoImageView.image = image
        }
        
        if let description = news.description {
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
