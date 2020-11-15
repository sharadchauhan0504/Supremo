//
//  RecentSearchListTableCell.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import UIKit

class RecentSearchListTableCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var moviePosterImageView: SwiftyImageDownloader! {
        didSet {
            moviePosterImageView.addCornerRadius(radius: moviePosterImageView.bounds.height * 0.5)
        }
    }
    @IBOutlet weak var movieNameLabel: UILabel!
    
    //MARK:- Public variables
    var recentSearch: SearchedResult? = nil {
        didSet {
            setRecentSearchedData()
        }
    }
    
    //MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- Private methods
    private func setRecentSearchedData() {
        guard let data = recentSearch else {return}
        movieNameLabel.text       = data.name
        if let url = URL(string: data.image.url) {
            moviePosterImageView.downloadImageFrom(url: url)
        }
    }
    
}
