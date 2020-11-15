//
//  SearchScreenViewModel.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import Foundation

class SearchScreenViewModel {
    
    // MARK:- Local Variables
    private let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: nil)
    
    //MARK:- Callbacks
    var apiFailureCallback: ((String) -> Void)?
    var getSearchedResultsCallback: (([SearchedResult]) -> Void)?
    
    // MARK: - Perform
    func perform(_ action: SearchScreenActions) {
        switch action {
        case .search(let query): searchSuperHeroes(query)
        }
    }
    
    //MARK:- Private methods
    private func searchSuperHeroes(_ query: String) {
        let api                  = SuperHeroAPIService.search(query)
        let router               = APIRouter<SuperHeroSearchOutput>(session: session)
        router.requestData(api) { [weak self] (output, statusCode, error) in
            guard let strongSelf = self else {return}
            if let data = output?.results, let callback = strongSelf.getSearchedResultsCallback {
                callback(data)
            } else if let callback = strongSelf.apiFailureCallback, let errorMessage = error?.localizedDescription {
                callback(errorMessage)
            } else if let callback = strongSelf.apiFailureCallback {
                callback(GenericErrors.invalidAPIResponse.message)
            }
        }
    }
    
}
