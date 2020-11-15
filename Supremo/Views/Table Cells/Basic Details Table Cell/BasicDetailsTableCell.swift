//
//  BasicDetailsTableCell.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import UIKit

class BasicDetailsTableCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var posterImageView: SwiftyImageDownloader! {
        didSet {
            posterImageView.addCornerRadius(radius: 12.0)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .warmPink
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK:- Public variables
    var character: SearchedResult? = nil {
        didSet {
            setCharacterData()
        }
    }
    
    //MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

    //MARK:- Private methods
    private func setCharacterData() {
        guard let data = character else {return}
        titleLabel.text       = data.name
        descriptionLabel.text = data.connections.groupAffiliation
        if let url = URL(string: data.image.url) {
            posterImageView.downloadImageFrom(url: url)
        }
    }
    
}
