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
        switch items[indexPath.section] {
        case .basic: return 300
        case .appearance: return UITableView.automaticDimension
        case .powerstats: return UITableView.automaticDimension
        case .biography: return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch items[section] {
        case .basic: return 0.0
        case .appearance: return 60
        case .powerstats: return 60
        case .biography: return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch items[section] {
        case .basic: return nil
        case .appearance: return addHeaderView("APPEARANCE", tableView.bounds.width)
        case .powerstats: return addHeaderView("POWER STATS", tableView.bounds.width)
        case .biography: return addHeaderView("BIOGRAPHY", tableView.bounds.width)
        }
    }
}

extension CharacterDetailScreenController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch items[section] {
        case .basic: return 1
        case .appearance: return 4
        case .powerstats: return 0
        case .biography: return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        switch item {
        case .basic:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicDetailsTableCell", for: indexPath) as! BasicDetailsTableCell
            cell.character = character
            return cell
        case .appearance:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DualLabelTableCell", for: indexPath) as! DualLabelTableCell
            switch indexPath.row {
            case 0:
                cell.leftLabel.text  = "Hair Colour"
                cell.rightLabel.text = character?.appearance.hairColor
            case 1:
                cell.leftLabel.text  = "Eye Colour"
                cell.rightLabel.text = character?.appearance.eyeColor
            case 2:
                cell.leftLabel.text  = "Height"
                cell.rightLabel.text = character?.appearance.height.first
            case 3:
                cell.leftLabel.text  = "Race"
                cell.rightLabel.text = character?.appearance.race
            default: break
            }
            return cell
        case .powerstats:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DualLabelTableCell", for: indexPath) as! DualLabelTableCell
            return cell
        case .biography:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DualLabelTableCell", for: indexPath) as! DualLabelTableCell
            switch indexPath.row {
            case 0:
                cell.leftLabel.text  = "Full Name"
                cell.rightLabel.text = character?.biography.fullName
            case 1:
                cell.leftLabel.text  = "Place of Birth"
                cell.rightLabel.text = character?.biography.placeOfBirth
            case 2:
                cell.leftLabel.text  = "First Appearance"
                cell.rightLabel.text = character?.biography.firstAppearance
            case 3:
                cell.leftLabel.text  = "Publisher"
                cell.rightLabel.text = character?.biography.publisher
            default: break
            }
            return cell
        }
        
    }
}
