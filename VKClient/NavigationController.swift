//
//  NavigationController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 15.06.2021.
//

import UIKit

class NavigationController: UINavigationController {
    
    let interactiveTransition = CustomInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return checkGalleryViewController([toVC, fromVC]) ? GalleryPushAnimator() : NavigationPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return checkGalleryViewController([toVC, fromVC]) ? GalleryPopAnimator() : NavigationPopAnimator()
        }
        
        return nil
    }
    
    func checkGalleryViewController(_ array: [UIViewController]) -> Bool {
        for viewController in array {
            if viewController as? GalleryViewController != nil {
                return true
            }
        }
        return false
    }
}
