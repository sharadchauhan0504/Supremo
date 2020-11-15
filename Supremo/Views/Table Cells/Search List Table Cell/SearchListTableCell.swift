//
//  SearchListTableCell.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import UIKit

class SearchListTableCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var backgroundShadowView: UIView! {
        didSet {
            backgroundShadowView.addShadow(radius: 6.0, height: 0.0, opacity: 0.35, shadowColor: .white)
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.addCornerRadius(radius: 16.0)
        }
    }
    @IBOutlet weak var posterImageView: SwiftyImageDownloader!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .warmPink
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK:- Public variables
    var searchedResult: SearchedResult? = nil {
        didSet {
            setSearchedResultData()
        }
    }
    
    //MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        accessibilityIdentifier = "tablecell--SearchListTableCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

    //MARK:- Private methods
    private func setSearchedResultData() {
        guard let data = searchedResult else {return}
        titleLabel.text       = data.name
        descriptionLabel.text = data.connections.groupAffiliation
        if let url = URL(string: data.image.url) {
            posterImageView.downloadImageFrom(url: url)
        }
    }
}
