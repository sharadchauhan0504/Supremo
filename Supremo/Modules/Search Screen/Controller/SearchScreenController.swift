//
//  SearchScreenController.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import UIKit

class SearchScreenController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.accessibilityTraits     = .searchField
            searchBar.accessibilityIdentifier = "searchbar--searchBar"
            searchBar.placeholder             = "Search SuperHeroes and Villians"
            searchBar.delegate                = self
            searchBar.showsCancelButton       = true
            searchBar.becomeFirstResponder()
        }
    }
    @IBOutlet weak var searchedResultsTableView: UITableView! {
        didSet {
            searchedResultsTableView.accessibilityIdentifier = "tableview--searchedResultsTableView"
            searchedResultsTableView.registerNib(type: SearchListTableCell.self)
        }
    }
    
    //MARK:- Private variables
    private let viewModel       = SearchScreenViewModel()
    private var searchedResults = [SearchedResult]()
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title                        = "Search"
        view.backgroundColor         = .black
        view.accessibilityIdentifier = "controller--SearchScreenController"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font(.installed(.PoppinsMedium), size: .custom(21.0)).instance, NSAttributedString.Key.foregroundColor: UIColor.warmPink]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //MARK:- Private methods
    private func openCharacterDetailScreen(_ character: SearchedResult) {
        let controller       = CharacterDetailScreenController()
        controller.character = character
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- API calls
    private func performSearch(_ query: String) {
       
        showActivityIndicator()
        viewModel.perform(.search(query))
        
        viewModel.getSearchedResultsCallback = { [weak self] results in
            guard let strongSelf = self else {return}
            strongSelf.searchedResults = results
            strongSelf.removeActivityIndicator()
            DispatchQueue.main.async {
                strongSelf.searchedResultsTableView.reloadData()
            }
        }
        
        viewModel.apiFailureCallback = { [weak self] errorMessage in
            guard let strongSelf = self else {return}
            strongSelf.removeActivityIndicator()
            strongSelf.showAlert(title: "Oops! Search Failure.", message: errorMessage, actionTitle: "Okay", completion: nil)
        }
    }
    
    //MARK:- Deinit
    deinit {
        print("deint: SearchScreenController")
    }
    
}
//MARK:- Extensions
extension SearchScreenController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        cell.bounceEffect { [weak self] in
            guard let strongSelf = self else {return}
            let character = strongSelf.searchedResults[indexPath.row]
            RecentSearchManager<SearchedResult>.saveCustomObjects(character, UserDefaultsKeys.recentSearches.key)
            strongSelf.openCharacterDetailScreen(character)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
}

extension SearchScreenController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableCell", for: indexPath) as! SearchListTableCell
        cell.searchedResult = searchedResults[indexPath.row]
        return cell
    }
    
}

//MARK:- UISearchbar delegate
extension SearchScreenController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        view.endEditing(true)
        performSearch(text.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text = nil
    }
    
}
