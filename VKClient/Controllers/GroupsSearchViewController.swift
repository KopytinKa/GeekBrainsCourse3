//
//  GroupsSearchViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 19.05.2021.
//

import UIKit

class GroupsSearchViewController: UIViewController {
    
    @IBOutlet weak var groupsSearchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let groupTableViewCellIdentifier = "GroupTableViewCellIdentifier"
    let addGroupSegueIdentifier = "addGroup"
    
    let apiVKService = VKService()
    
    var searchGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupsSearchTableView.dataSource = self
        groupsSearchTableView.delegate = self
        groupsSearchTableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupTableViewCellIdentifier)
        
        searchBar.delegate = self
    }
}

extension GroupsSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupTableViewCellIdentifier, for: indexPath) as? GroupTableViewCell
        else {
            return UITableViewCell()
        }
        
        let group = searchGroups[indexPath.row]

        cell.configure(group: group)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: addGroupSegueIdentifier, sender: nil)
    }
}

extension GroupsSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            apiVKService.getGroupsListWith(query: searchText) { groups in
                self.searchGroups = groups
                self.groupsSearchTableView.reloadData()
            }
        }
    }
}
