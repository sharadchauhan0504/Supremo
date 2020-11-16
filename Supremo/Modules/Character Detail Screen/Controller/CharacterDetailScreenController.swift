//
//  CharacterDetailScreenController.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import UIKit

class CharacterDetailScreenController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var characterDetailsTableView: UITableView! {
        didSet {
            characterDetailsTableView.accessibilityIdentifier = "tableview--characterDetailsTableView"
            characterDetailsTableView.registerNib(type: BasicDetailsTableCell.self)
            characterDetailsTableView.registerNib(type: DualLabelTableCell.self)
            characterDetailsTableView.registerNib(type: PowerStatsTableCell.self)
        }
    }
    
    //MARK:- Private variables
    private let items = CharacterDetailTableData.allCases
    
    //MARK:- Public variables
    var character: SearchedResult?
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title                        = character?.name
        view.backgroundColor         = .black
        view.accessibilityIdentifier = "controller--CharacterDetailScreenController"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font(.installed(.PoppinsMedium), size: .custom(21.0)).instance, NSAttributedString.Key.foregroundColor: UIColor.warmPink]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //MARK:- Private methods
    private func addHeaderView(_ name: String, _ width: CGFloat) -> UIView {
        let headerView  = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 60.0))
        let label       = UILabel(frame: CGRect(x: 24.0, y: 0.0, width: width, height: 60))
        label.text      = name
        label.textColor = .warmPink
        label.font      = Font(.installed(.PoppinsSemiBold), size: .custom(20.0)).instance
        headerView.addSubview(label)
        return headerView
    }

    //MARK:- Deinit
    deinit {
        print("deint: CharacterDetailScreenController")
    }
}

//MARK:- Extensions
extension CharacterDetailScreenController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        items[indexPath.section].rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        items[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        addHeaderView(items[section].headerTitle, tableView.bounds.width)
    }
}

extension CharacterDetailScreenController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        switch item {
        case .basic:
            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as! BasicDetailsTableCell
            cell.character = character
            return cell
        case .appearance:
            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as! DualLabelTableCell
            switch indexPath.row {
            case 0: cell.hairColor = character?.appearance.hairColor
            case 1: cell.eyeColor  = character?.appearance.eyeColor
            case 2: cell.height    = character?.appearance.height.first
            case 3: cell.race      = character?.appearance.race
            default: break
            }
            return cell
        case .powerstats:
            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as! PowerStatsTableCell
            switch indexPath.row {
            case 0: cell.intelligence = character?.powerstats.intelligence
            case 1: cell.strength     = character?.powerstats.strength
            case 2: cell.speed        = character?.powerstats.speed
            case 3: cell.durability   = character?.powerstats.durability
            case 4: cell.power        = character?.powerstats.power
            case 5: cell.combat       = character?.powerstats.combat
            default: break
            }
            return cell
        case .biography:
            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as! DualLabelTableCell
            switch indexPath.row {
            case 0: cell.fullName        = character?.biography.fullName
            case 1: cell.placeOfBirth    = character?.biography.placeOfBirth
            case 2: cell.firstAppearance = character?.biography.firstAppearance
            case 3: cell.publisher       = character?.biography.publisher
            default: break
            }
            return cell
        }
        
    }
}
