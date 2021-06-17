//
//  GroupsListViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 19.05.2021.
//

import UIKit

class GroupsListViewController: UIViewController {

    @IBOutlet weak var groupsListTableView: UITableView!
    
    let groupTableViewCellIdentifier = "GroupTableViewCellIdentifier"
    let addGroupSegueIdentifier = "addGroup"
        
    override func viewDidLoad() {
        super.viewDidLoad()

        groupsListTableView.dataSource = self
        groupsListTableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupTableViewCellIdentifier)
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == addGroupSegueIdentifier {
            guard let groupSearchViewController = segue.source as? GroupsSearchViewController else { return }
            
            if let indexPath = groupSearchViewController.groupsSearchTableView.indexPathForSelectedRow {
                let group = DataStorage.shared.allGroupsArray[indexPath.row]
                
                if !DataStorage.shared.myGroupsArray.contains(group) {
                    DataStorage.shared.myGroupsArray.append(group)
                    groupsListTableView.reloadData()
                }
            }
        }
    }
}

extension GroupsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupTableViewCellIdentifier, for: indexPath) as? GroupTableViewCell
        else {
            return UITableViewCell()
        }
        
        let group = DataStorage.shared.myGroupsArray[indexPath.row]
        
        cell.configure(group: group)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            DataStorage.shared.myGroupsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
