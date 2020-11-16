//
//  CharacterDetailTableData.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import UIKit

enum CharacterDetailTableData: CaseIterable {
    
    case basic
    case appearance
    case powerstats
    case biography
        
    var identifier: String {
        switch self {
        case .basic: return String(describing: BasicDetailsTableCell.self)
        case .appearance, .biography: return String(describing: DualLabelTableCell.self)
        case .powerstats: return String(describing: PowerStatsTableCell.self)
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .basic: return 300
        case .appearance, .biography, .powerstats: return UITableView.automaticDimension
        }
    }
    
    var headerHeight: CGFloat {
        switch self {
        case .basic: return 0
        case .appearance, .biography, .powerstats: return 60
        }
    }
    
    var headerTitle: String {
        switch self {
        case .basic: return "BASIC"
        case .appearance: return "APPEARANCE"
        case .biography: return "BIOGRAPHY"
        case .powerstats: return "POWER STATS"
        }
    }
    
    var numberOfRows: Int {
        switch self {
        case .basic: return 1
        case .appearance: return 4
        case .biography: return 4
        case .powerstats: return 6
        }
    }
}
