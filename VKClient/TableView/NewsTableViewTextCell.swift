//
//  NewsTableViewTextCell.swift
//  VKClient
//
//  Created by Кирилл Копытин on 13.08.2021.
//

import UIKit

protocol NewsTableViewTextCellDelegate: AnyObject {
    func showMoreAction(_ cell: NewsTableViewTextCell)
}

class NewsTableViewTextCell: UITableViewCell {
    
    weak var delegate: NewsTableViewTextCellDelegate?
        
    static let smallIndent: CGFloat = 5.0
    
    static let buttonWidth: CGFloat = 100.0
    static let buttonHeight: CGFloat = 20.0
    
    static let defaultTextHeight: CGFloat = 200.0
        
    @IBOutlet weak var showMoreOrLessButton: UIButton! {
        didSet {
            showMoreOrLessButton.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBAction func showMoreOrLessAction(_ sender: Any) {
        delegate?.showMoreAction(self)
    }
    
    func descriptionLabelFrame(height: CGFloat) {
        descriptionLabel.frame = CGRect(x: Self.smallIndent, y: Self.smallIndent, width: contentView.frame.width - Self.smallIndent * 2, height: height)
    }
    
    func shomMoreButtonFrame(title: String) {
        showMoreOrLessButton.frame = CGRect(x: Self.smallIndent, y: descriptionLabel.frame.maxY + Self.smallIndent, width: Self.buttonWidth, height: Self.buttonHeight)
        showMoreOrLessButton.isHidden = false
        showMoreOrLessButton.backgroundColor = Styles.brandLightBlue
        showMoreOrLessButton.setTitle(title, for: .normal)
    }
    
    func setup() {
    }
    
    func clearCell() {
        descriptionLabel.text = nil
        showMoreOrLessButton.isHidden = true
    }
    
    func configure(news: NewViewModel) {
        if let description = news.text {
            descriptionLabel.text = description

            if news.heightText < Self.defaultTextHeight || news.isExpanded {
                descriptionLabelFrame(height: news.heightText)
                if news.isExpanded {
                    shomMoreButtonFrame(title: "Скрыть")
                }
            } else {
                descriptionLabelFrame(height: Self.defaultTextHeight)
                shomMoreButtonFrame(title: "Показать")
            }
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
