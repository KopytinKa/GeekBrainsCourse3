//
//  NavigationPushAnimator.swift
//  VKClient
//
//  Created by Кирилл Копытин on 15.06.2021.
//

import UIKit

final class NavigationPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = source.view.frame
        let translation = CGAffineTransform(translationX: 0, y: source.view.frame.height)
        let rotation = CGAffineTransform(rotationAngle: .pi / -2)
        destination.view.transform = translation.concatenating(rotation)
        
        UIView.animateKeyframes(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {                
                UIView.addKeyframe(
                    withRelativeStartTime: 0.2,
                    relativeDuration: 0.4,
                    animations: {
                        let translation = CGAffineTransform(translationX: 0, y: source.view.frame.height / 2)
                        let rotation = CGAffineTransform(rotationAngle: .pi / -4)
                        destination.view.transform = translation.concatenating(rotation)
                    }
                )
                
                UIView.addKeyframe(
                    withRelativeStartTime: 0.6,
                    relativeDuration: 0.4,
                    animations: {
                        destination.view.transform = .identity
                    }
                )
            }
        ) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
