//
//  FriendsPhotosViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 20.05.2021.
//

import UIKit

class FriendsPhotosViewController: UIViewController {

    @IBOutlet weak var friendPhotosCollectionView: UICollectionView!
    
    var photos = [Photo]()
    var friendId:Int = 0
    
    let apiVKService = VKService()
    
    let friendPhotosCollectionViewCellIdentifier = "FriendPhotosCollectionViewCellIdentifier"
    let fromFriendsPhotosToGallerySegueIdentifier = "fromPhotosToGallery"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhotosBy(userId: friendId)

        friendPhotosCollectionView.dataSource = self
        friendPhotosCollectionView.delegate = self
        friendPhotosCollectionView.register(UINib(nibName: "FriendPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: friendPhotosCollectionViewCellIdentifier)
    }
    
    func setPhotosBy(userId: Int) {
        apiVKService.getPhotos(by: userId) { [weak self] photos in
            guard let self = self else { return }
            self.photos = photos
            self.friendPhotosCollectionView.reloadData()
        }
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
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendPhotosCollectionViewCellIdentifier, for: indexPath) as? FriendPhotosCollectionViewCell
        else {
            return UICollectionViewCell()
        }
    
        let photo = photos[indexPath.row]
        
        cell.configure(photo: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: fromFriendsPhotosToGallerySegueIdentifier, sender: indexPath)
    }
}
