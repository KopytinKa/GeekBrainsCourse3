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
        countLikesLabel.text = nil
        countViewsLabel.text = nil
        countRepostsLabel.text = nil
        countCommentsLabel.text = nil
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeFlag = false
    }
    
    func configure(news: FirebaseNew) {
        if let image = news.urlImage {
            photoImageView.sd_setImage(with: URL(string: image))
        }
        
        if let description = news.text {
            descriptionLabel.text = description
        }
        
        countLikesLabel.text = String(news.likesCount)
        countViewsLabel.text = String(news.viewsCount)
        countRepostsLabel.text = String(news.repostsCount)
        countCommentsLabel.text = String(news.commentsCount)
        
        if news.userLikes > 0 {
            likeFlag = true
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
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
