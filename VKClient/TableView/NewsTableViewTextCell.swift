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
        descriptionLabel.frame = CGRect(x: NewsTableViewTextCell.smallIndent, y: NewsTableViewTextCell.smallIndent, width: contentView.frame.width - NewsTableViewTextCell.smallIndent * 2, height: height)
    }
    
    func shomMoreButtonFrame(title: String) {
        showMoreOrLessButton.frame = CGRect(x: NewsTableViewTextCell.smallIndent, y: descriptionLabel.frame.maxY + NewsTableViewTextCell.smallIndent, width: NewsTableViewTextCell.buttonWidth, height: NewsTableViewTextCell.buttonHeight)
        showMoreOrLessButton.isHidden = false
        showMoreOrLessButton.backgroundColor = #colorLiteral(red: 0, green: 0.7406748533, blue: 0.9497854114, alpha: 1)
        showMoreOrLessButton.setTitle(title, for: .normal)
    }
    
    func setup() {
    }
    
    func clearCell() {
        descriptionLabel.text = nil
        showMoreOrLessButton.isHidden = true
    }
    
    func configure(news: FirebaseNew) {
        if let description = news.text {
            descriptionLabel.text = description

            if news.heightText < NewsTableViewTextCell.defaultTextHeight || news.isExpanded {
                descriptionLabelFrame(height: news.heightText)
                if news.isExpanded {
                    shomMoreButtonFrame(title: "Скрыть")
                }
            } else {
                descriptionLabelFrame(height: NewsTableViewTextCell.defaultTextHeight)
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
