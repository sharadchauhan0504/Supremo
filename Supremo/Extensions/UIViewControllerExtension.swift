//
//  UIViewControllerExtension.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actionTitle: String, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.cancel, handler: { _ in
                completion?() ?? ()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showActivityIndicator() {
        let activityIndicator    = UIActivityIndicatorView(style: .large)
        activityIndicator.color  = .white
        activityIndicator.center = view.center
        activityIndicator.tag    = 10001
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            let activityIndicator = self.view.viewWithTag(10001)
            activityIndicator?.removeFromSuperview()
        }
    }
}
