//
//  UITableViewExtension.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import UIKit

extension UITableView {
    
    func registerNib(type: UITableViewCell.Type) {
        let identifier = String(describing: type.self)
        let nib        = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }
}
