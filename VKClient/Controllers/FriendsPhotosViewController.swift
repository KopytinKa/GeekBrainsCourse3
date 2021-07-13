//
//  FriendsPhotosViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 20.05.2021.
//

import UIKit
import RealmSwift

class FriendsPhotosViewController: UIViewController {

    @IBOutlet weak var friendPhotosCollectionView: UICollectionView!
    
    let apiVKService = VKService()
    let realmService = RealmService()
    
    var token: NotificationToken?
    
    let friendPhotosCollectionViewCellIdentifier = "FriendPhotosCollectionViewCellIdentifier"
    let fromFriendsPhotosToGallerySegueIdentifier = "fromPhotosToGallery"
    
    var photos: Results<PhotoModel>? {
        didSet {
            token = photos?.observe { [weak self] changes in
                guard let self = self else { return }
                
                switch changes {
                case .initial:
                    self.friendPhotosCollectionView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self.friendPhotosCollectionView.performBatchUpdates({
                        self.friendPhotosCollectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                        self.friendPhotosCollectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0) }))
                        self.friendPhotosCollectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                    }, completion: nil)
                case .error(let error):
                    fatalError("\(error)")
                }
            }
        }
    }
    var friendId:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhotosBy(userId: friendId)

        friendPhotosCollectionView.dataSource = self
        friendPhotosCollectionView.delegate = self
        friendPhotosCollectionView.register(UINib(nibName: "FriendPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: friendPhotosCollectionViewCellIdentifier)
    }
    
    func setPhotosBy(userId: Int) {
        apiVKService.getPhotos(by: userId)
        
        guard let realm = try? Realm() else { return }
        photos = realm.objects(PhotoModel.self).filter("ownerID == \(userId)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsPhotosToGallerySegueIdentifier {
            guard let galleryViewController = segue.destination as? GalleryViewController else { return }
            
            guard let indexPath = sender as? IndexPath else { return }
            
            galleryViewController.galleryPhotos = photos
            galleryViewController.selectedImageIndex = indexPath.item
        }
    }
}

extension FriendsPhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendPhotosCollectionViewCellIdentifier, for: indexPath) as? FriendPhotosCollectionViewCell
        else {
            return UICollectionViewCell()
        }
    
        if let photo = photos?[indexPath.row] {
            cell.configure(photo: photo)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: fromFriendsPhotosToGallerySegueIdentifier, sender: indexPath)
    }
}
