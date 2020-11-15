//
//  HomeScreenController.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import UIKit

class HomeScreenController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var recentSearchTableView: UITableView! {
        didSet {
            recentSearchTableView.accessibilityIdentifier = "tableview--recentSearchTableView"
            recentSearchTableView.registerNib(type: RecentSearchListTableCell.self)
        }
    }
    
    //MARK:- Private variables
    private let viewModel      = HomeScreenViewModel()
    private var recentSearches = [SearchedResult]()

    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title                        = "Supremo"
        view.backgroundColor         = .black
        view.accessibilityIdentifier = "controller--HomeScreenController"
        initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecentSearches()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font(.installed(.PoppinsMedium), size: .custom(21.0)).instance, NSAttributedString.Key.foregroundColor: UIColor.warmPink]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //MARK:- Private methods
    private func initialSetup() {
        //Search Icon
        let searchIconBarButton                     = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tappedOnSearchBarButton(_:)))
        searchIconBarButton.tintColor               = .white
        searchIconBarButton.accessibilityIdentifier = "button--searchIconBarButton"
        navigationItem.rightBarButtonItem           = searchIconBarButton
    }
    
    @objc private func tappedOnSearchBarButton(_ sender: UIButton) {
        openSearchScreen()
    }
    
    private func openSearchScreen() {
        let controller = SearchScreenController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func openCharacterDetailScreen(_ character: SearchedResult) {
        let controller       = CharacterDetailScreenController()
        controller.character = character
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func getRecentSearches() {
        recentSearches = viewModel.getRecentSearches()
        recentSearchTableView.reloadData()
    }
    
    //MARK:- Deinit
    deinit {
        print("deint: HomeScreenController")
    }
    
}
//MARK:- Extensions
extension HomeScreenController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        cell.bounceEffect { [weak self] in
            guard let strongSelf = self else {return}
            let character = strongSelf.recentSearches[indexPath.row]
            strongSelf.openCharacterDetailScreen(character)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return recentSearches.isEmpty ? 0.0 : 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView  = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 60.0))
        let label       = UILabel(frame: CGRect(x: 24.0, y: 0.0, width: tableView.bounds.width, height: 60))
        label.text      = "Recent Searches"
        label.textColor = .white
        label.font      = Font(.installed(.PoppinsRegular), size: .custom(20.0)).instance
        headerView.addSubview(label)
        return headerView
    }
    
}

extension HomeScreenController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchListTableCell", for: indexPath) as! RecentSearchListTableCell
        cell.recentSearch = recentSearches[indexPath.item]
        return cell
    }
}
