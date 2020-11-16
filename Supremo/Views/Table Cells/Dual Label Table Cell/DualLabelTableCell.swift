//
//  DualLabelTableCell.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import UIKit

class DualLabelTableCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    //MARK:- Public variables
    //- Appearance
    var hairColor: String? = nil {
        didSet {
            setHairColor()
        }
    }
    
    var eyeColor: String? = nil {
        didSet {
            setEyeColor()
        }
    }
    
    var height: String? = nil {
        didSet {
            setHeight()
        }
    }
    
    var race: String? = nil {
        didSet {
            setRace()
        }
    }
    
    //- Biography
    var fullName: String? = nil {
        didSet {
            setFullName()
        }
    }
    
    var placeOfBirth: String? = nil {
        didSet {
            setPlaceOfBirth()
        }
    }
    
    var firstAppearance: String? = nil {
        didSet {
            setFirstAppearance()
        }
    }
    
    var publisher: String? = nil {
        didSet {
            
        }
    }
    
    //MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- Private methods
    private func setHairColor() {
        guard let data = hairColor else {return}
        leftLabel.text  = "Hair Colour"
        rightLabel.text = data
    }
    
    private func setEyeColor() {
        guard let data = eyeColor else {return}
        leftLabel.text  = "Eye Colour"
        rightLabel.text = data
    }
    
    private func setHeight() {
        guard let data = height else {return}
        leftLabel.text  = "Height"
        rightLabel.text = data
    }
    
    private func setRace() {
        guard let data = race else {return}
        leftLabel.text  = "Race"
        rightLabel.text = data
    }
    
    private func setFullName() {
        guard let data = fullName else {return}
        leftLabel.text  = "Full Name"
        rightLabel.text = data
    }
    
    private func setPlaceOfBirth() {
        guard let data = placeOfBirth else {return}
        leftLabel.text  = "Place of Birth"
        rightLabel.text = data
    }
    
    private func setFirstAppearance() {
        guard let data = firstAppearance else {return}
        leftLabel.text  = "First Appearance"
        rightLabel.text = data
    }
    
    private func setPublisher() {
        guard let data = publisher else {return}
        leftLabel.text  = "Publisher"
        rightLabel.text = data
    }
}
