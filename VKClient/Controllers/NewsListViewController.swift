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
    
    let newsTableViewCellIdentifier = "NewsTableViewCellIdentifier"
    
    let apiVKService = VKService()
    
    private var news = [FirebaseNew]()
    private let ref = Database.database().reference(withPath: "news/\(Session.shared.userId)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNews()

        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: newsTableViewCellIdentifier)
        
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
            
            self.news = news
            self.newsTableView.reloadData()
        })
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: newsTableViewCellIdentifier, for: indexPath) as? NewsTableViewCell
        else {
            return UITableViewCell()
        }
        
        let new = news[indexPath.row]

        cell.configure(news: new)
        
        return cell
    }
}
