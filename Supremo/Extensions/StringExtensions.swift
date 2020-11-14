//
//  StringExtensions.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import Foundation

extension String {
    
    func fileName() -> String {
        return self.replacingOccurrences(of: "[/+.:.-]", with: "", options: .regularExpression, range: nil)
    }
    
}
