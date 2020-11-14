//
//  UIView+Extension.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import UIKit

extension UIView {
  
    //MARK: - Add Shadow
    func addShadow(radius: CGFloat = 8.0, height: CGFloat = 5.0, opacity: Float = 0.3, shadowColor: UIColor = .black) {
        layer.masksToBounds = false
        layer.shadowOffset  = CGSize(width: 0.0, height: height)
        layer.shadowOpacity = opacity
        layer.shadowColor   = shadowColor.cgColor
        layer.shadowRadius  = radius
    }
    
    func addCornerRadius(radius: CGFloat = 7.0) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat = 8) {
        let maskPath1    = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1   = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path  = maskPath1.cgPath
        layer.mask       = maskLayer1
    }
    
    func fadeInEffect(duration: TimeInterval = 0.5, delay: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
            self.alpha = 1.0
        }) { (success) in
            
        }
    }
    
    func bounceEffect(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }) { (success) in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                self.transform = .identity
            }) { (success) in
                completion?()
            }
        }
    }
    
}
