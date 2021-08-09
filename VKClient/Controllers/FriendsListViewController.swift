//
//  FriendsListViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 19.05.2021.
//

import UIKit

class FriendsListViewController: UIViewController {

    @IBOutlet weak var friendsListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let friendTableViewCellIdentifier = "FriendTableViewCellIdentifier"
    let fromFriendsListToFriendsPhotosSegueIdentifier = "fromFriendsListToFriendsPhotos"
    
    let apiVKService = VKService()
    let realmService = RealmService()
    
    var friends = [UserModel]()
    var searchFriends = [UserModel]()
    
    var searchFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFriends()

        friendsListTableView.dataSource = self
        friendsListTableView.delegate = self
        friendsListTableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: friendTableViewCellIdentifier)
        
        searchBar.delegate = self
    }
    
    func setFriends() {
        apiVKService.getFriendsList(by: nil)
        
        if let friends = self.realmService.read(object: UserModel.self) as? [UserModel] {
            self.friends = friends
            self.friendsListTableView.reloadData()
        }
    }
    
    func getMyFriends() -> [UserModel] {
        if searchFlag {
            return searchFriends
        }
        
        return friends
    }
    
    func arrayLetter() -> [String] {
        var resultArray = [String]()
        
        for friend in getMyFriends() {
            let nameLetter = String(friend.getFullName().prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }
        
        resultArray = resultArray.sorted(by: <)
        
        return resultArray
    }
    
    func arrayByLetter(letter: String) -> [UserModel] {
        var resultArray = [UserModel]()
        
        for friend in getMyFriends() {
            let nameLetter = String(friend.getFullName().prefix(1))
            if nameLetter == letter {
                resultArray.append(friend)
            }
        }
        
        return resultArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsListToFriendsPhotosSegueIdentifier {
            guard let friendsPhotosViewController = segue.destination as? FriendsPhotosViewController else { return }
            
            guard let indexPath = sender as? IndexPath else { return }
            let friend = arrayByLetter(letter: arrayLetter()[indexPath.section])[indexPath.row]
            
            friendsPhotosViewController.friendId = friend.id
        }
    }
}

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetter()[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: friendTableViewCellIdentifier, for: indexPath) as? FriendTableViewCell
        else {
            return UITableViewCell()
        }
        
        let arrayByLetter = arrayByLetter(letter: arrayLetter()[indexPath.section])
        let friend = arrayByLetter[indexPath.row]
        
        cell.configure(user: friend)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: fromFriendsListToFriendsPhotosSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetter()[section].uppercased()
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return arrayLetter()
    }
}

extension FriendsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchFlag = false
        } else {
            searchFlag = true
            searchFriends = friends.filter({
                $0.getFullName().lowercased().contains(searchText.lowercased())
            })
        }

        friendsListTableView.reloadData()
    }
}
