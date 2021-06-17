//
//  GroupsSearchViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 19.05.2021.
//

import UIKit

class GroupsSearchViewController: UIViewController {
    
    @IBOutlet weak var groupsSearchTableView: UITableView!
    
    let groupTableViewCellIdentifier = "GroupTableViewCellIdentifier"
    let addGroupSegueIdentifier = "addGroup"

    
    var groups = [
        Group(name: "Комиксы BUBBLE", avatar: UIImage(named: "bubble")),
        Group(name: "Любители собак", avatar: nil),
        Group(name: "Азбука - графические романы", avatar: UIImage(named: "azbuka")),
        Group(name: "Издательство Сокол", avatar: UIImage(named: "sokol")),
        Group(name: "Бегуны", avatar: nil),
        Group(name: "Магазин комиксов Сomic Street", avatar: UIImage(named: "comic_street")),
        Group(name: "Eaglemoss", avatar: UIImage(named: "eaglemoss")),
        Group(name: "Любители кошек", avatar: UIImage(named: "cats"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupsSearchTableView.dataSource = self
        groupsSearchTableView.delegate = self
        groupsSearchTableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupTableViewCellIdentifier)
    }
}

extension GroupsSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.allGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupTableViewCellIdentifier, for: indexPath) as? GroupTableViewCell
        else {
            return UITableViewCell()
        }
        
        let group = DataStorage.shared.allGroupsArray[indexPath.row]

        cell.configure(group: group)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: addGroupSegueIdentifier, sender: nil)
    }
}
