//
//  NewsListViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 31.05.2021.
//

import UIKit
import FirebaseDatabase

class NewsListViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    let newsTableViewCellTextIdentifier = "NewsTableViewCellTextIdentifier"
    let newsTableViewCellImageIdentifier = "NewsTableViewCellImageIdentifier"
    let newsTableViewCellCountersIdentifier = "NewsTableViewCellCountersIdentifier"
    
    let apiVKService = VKService()
    
    private var news = [FirebaseNew]()
    private let ref = Database.database().reference(withPath: "news/\(Session.shared.userId)")
    
    var nextFrom = ""
    var isLoading = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNews()
        setupRefreshControl()

        newsTableView.dataSource = self
        newsTableView.prefetchDataSource = self
        newsTableView.delegate = self
        
        newsTableView.allowsSelection = false
        
        newsTableView.register(UINib(nibName: "NewsTableViewTextCell", bundle: nil), forCellReuseIdentifier: newsTableViewCellTextIdentifier)
        newsTableView.register(UINib(nibName: "NewsTableViewImageCell", bundle: nil), forCellReuseIdentifier: newsTableViewCellImageIdentifier)
        newsTableView.register(UINib(nibName: "NewsTableViewCountersCell", bundle: nil), forCellReuseIdentifier: newsTableViewCellCountersIdentifier)
    }
    
    fileprivate func setupRefreshControl() {
        newsTableView.refreshControl = UIRefreshControl()
        
        newsTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        newsTableView.refreshControl?.tintColor = #colorLiteral(red: 0, green: 0.7406748533, blue: 0.9497854114, alpha: 1)
        newsTableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc func refreshNews() {
        newsTableView.refreshControl?.beginRefreshing()
        
        let mostFreshNewsDate = self.news.first?.date ?? Int(Date().timeIntervalSince1970)
        
        apiVKService.getNewsfeed(startTime: mostFreshNewsDate) { [weak self] nextFrom in
            guard let self = self else { return }
            self.nextFrom = nextFrom
        }
        
        newsTableView.refreshControl?.endRefreshing()
    }
    
    func setNews() {
        apiVKService.getNewsfeed() { [weak self] nextFrom in
            guard let self = self else { return }
            self.nextFrom = nextFrom
        }
        
        ref.observe(.value, with: { [weak self] snapshot in
            guard let self = self else { return }
            var news: [FirebaseNew] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let new = FirebaseNew(snapshot: snapshot) {
                       news.append(new)
                }
            }
            
            news.sort(by: { $0.date > $1.date })
            
            news.forEach({ $0.calculateTextHeight(from: self.view.frame.width)})
            
            self.news = news
            self.newsTableView.reloadData()
        })
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 1
        if news[section].text != nil { rows += 1}
        if news[section].urlImage != nil { rows += 1}
        return rows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let new = news[indexPath.section]
        
        if new.text != nil && indexPath.row == 0 {

            if new.heightText < NewsTableViewTextCell.defaultTextHeight {
                return new.heightText + NewsTableViewTextCell.smallIndent
            } else if new.isExpanded {
                return new.heightText + NewsTableViewTextCell.buttonHeight + NewsTableViewTextCell.smallIndent * 2
            } else {
                return NewsTableViewTextCell.defaultTextHeight + NewsTableViewTextCell.buttonHeight + NewsTableViewTextCell.smallIndent * 2
            }
        } else if (new.text == nil && new.urlImage != nil && indexPath.row == 0 ) ||
            (new.text != nil && new.urlImage != nil && indexPath.row == 1) {
            let tableWidth = tableView.bounds.width
            let cellHeight = tableWidth * new.aspectRatio + NewsTableViewImageCell.smallIndent
            return cellHeight
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = news[indexPath.section]
        
        if new.text != nil && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: newsTableViewCellTextIdentifier, for: indexPath) as? NewsTableViewTextCell
            else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(news: new)
            
            return cell
        } else if new.urlImage != nil && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: newsTableViewCellImageIdentifier, for: indexPath) as? NewsTableViewImageCell
            else {
                return UITableViewCell()
            }
            cell.configure(news: new)

            return cell
        } else if new.text != nil && new.urlImage != nil && indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: newsTableViewCellImageIdentifier, for: indexPath) as? NewsTableViewImageCell
            else {
                return UITableViewCell()
            }
            cell.configure(news: new)

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: newsTableViewCellCountersIdentifier, for: indexPath) as? NewsTableViewCountersCell
            else {
                return UITableViewCell()
            }
            cell.configure(news: new)
            
            return cell
        }
    }
}

extension NewsListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        if maxSection > news.count - 3, !isLoading {
            isLoading = true
            
            apiVKService.getNewsfeed(startFrom: nextFrom) { [weak self] nextFrom in
                guard let self = self else { return }
                self.nextFrom = nextFrom
                
                self.isLoading = false
            }
        }
    }
}

extension NewsListViewController: NewsTableViewTextCellDelegate {
    func showMoreAction(cell: NewsTableViewTextCell) {
        guard let indexPath = newsTableView.indexPath(for: cell) else { return }
        let new = news[indexPath.section]
        
        new.isExpanded = !new.isExpanded

        newsTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
