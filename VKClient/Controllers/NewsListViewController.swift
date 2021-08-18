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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNews()
        setupRefreshControl()

        newsTableView.dataSource = self
        
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
        
        apiVKService.getNewsfeed(startTime: mostFreshNewsDate)
        
        newsTableView.refreshControl?.endRefreshing()
    }
    
    func setNews() {
        apiVKService.getNewsfeed()
        
        ref.observe(.value, with: { [weak self] snapshot in
            guard let self = self else { return }
            var news: [FirebaseNew] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let new = FirebaseNew(snapshot: snapshot) {
                       news.append(new)
                }
            }
            
            news.sort(by: { $0.date > $1.date } )
            
            self.news = news
            self.newsTableView.reloadData()
        })
    }
}

extension NewsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 1
        if news[section].text != nil { rows += 1}
        if news[section].urlImage != nil { rows += 1}
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = news[indexPath.section]
        
        if new.text != nil && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: newsTableViewCellTextIdentifier, for: indexPath) as? NewsTableViewTextCell
            else {
                return UITableViewCell()
            }
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
