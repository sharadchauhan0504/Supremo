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
            searchedResultsTableView.registerNib(type: SingleLabelTableCell.self)
        }
    }
    
    //MARK:- Private variables
    private let viewModel       = SearchScreenViewModel()
    private var searchedResults = [SearchedResult]()
    private var recentSearches  = [RecentSearches]()
    private var isSearching     = false

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
    private func getRecentSearches() {
        recentSearches = viewModel.getRecentSearches()
        searchedResultsTableView.reloadData()
    }
    
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
            strongSelf.isSearching     = false
            strongSelf.searchedResults = results
            strongSelf.removeActivityIndicator()
            let recentSearch = RecentSearches(query: query)
            RecentSearchManager<RecentSearches>.saveCustomObjects(recentSearch, UserDefaultsKeys.recentSearches.key)
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
            if strongSelf.isSearching {
                let query                 = strongSelf.recentSearches[indexPath.row].query
                strongSelf.searchBar.text = query
                strongSelf.performSearch(query)
            } else {
                let character = strongSelf.searchedResults[indexPath.row]
                RecentSearchManager<SearchedResult>.saveCustomObjects(character, UserDefaultsKeys.recentlyViewed.key)
                strongSelf.openCharacterDetailScreen(character)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearching {
            return UITableView.automaticDimension
        } else {
            return 140.0
        }
    }
}

extension SearchScreenController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return recentSearches.count
        } else {
            return searchedResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearching {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleLabelTableCell", for: indexPath) as! SingleLabelTableCell
            cell.titleLabel.text = recentSearches[indexPath.row].query
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableCell", for: indexPath) as! SearchListTableCell
            cell.searchedResult = searchedResults[indexPath.row]
            return cell
        }
        
    }
    
}

//MARK:- UISearchbar delegate
extension SearchScreenController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        getRecentSearches()
    }
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        isSearching = false
        view.endEditing(true)
        performSearch(text.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text = nil
        isSearching    = false
        searchedResultsTableView.reloadData()
    }
    
}
