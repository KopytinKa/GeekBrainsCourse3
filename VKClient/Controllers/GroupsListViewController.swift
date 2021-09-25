//
//  GroupsListViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 19.05.2021.
//

import UIKit
import RealmSwift
import FirebaseDatabase
import PromiseKit

class GroupsListViewController: UIViewController {

    @IBOutlet weak var groupsListTableView: UITableView!
    
    let groupTableViewCellIdentifier = "GroupTableViewCellIdentifier"
    let addGroupSegueIdentifier = "addGroup"
    
    let apiVKService = GroupAdapter()
    let realmService = RealmService()
        
    private let ref = Database.database().reference(withPath: "usersGroups")
    
    var groups = [Group]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiVKService.getGroups(by: nil) { [weak self] groups in
            guard let self = self else { return }
            self.groups = groups
            self.groupsListTableView.reloadData()
        }
        
        groupsListTableView.dataSource = self
        groupsListTableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupTableViewCellIdentifier)
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == addGroupSegueIdentifier {
            guard let groupSearchViewController = segue.source as? GroupsSearchViewController else { return }
            
            if let indexPath = groupSearchViewController.groupsSearchTableView.indexPathForSelectedRow {
                let group = groupSearchViewController.searchGroups[indexPath.row]
                let realmGroup = GroupModel(group: group)
                
                realmService.add(models: [realmGroup])
                
                let groupAdded = FirebaseGroupAdded(id: group.id, name: group.name, avatar: group.avatar)
                let groupRef = self.ref.child(Session.shared.userId).child(group.name)
                groupRef.setValue(groupAdded.toAnyObject())
            }
        }
    }
}

extension GroupsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupTableViewCellIdentifier, for: indexPath) as? GroupTableViewCell
        else {
            return UITableViewCell()
        }
        
        let group = groups[indexPath.row]
        cell.configure(group: group)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let group = groups[indexPath.row]
            let realmGroup = realmService.realm.objects(GroupModel.self).filter("id == \(group.id)")
            realmService.realm.beginWrite()
            realmService.realm.delete(realmGroup)
            try? realmService.realm.commitWrite()
        }
    }
}
