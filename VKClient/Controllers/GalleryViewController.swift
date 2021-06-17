//
//  GalleryViewController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 11.06.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryView: GalleryHorisontalView!
    
    var galleryPhotos = [UIImage]()
    var selectedImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryView.setImages(images: galleryPhotos, showIndexPhoto: selectedImageIndex)
    }
}
