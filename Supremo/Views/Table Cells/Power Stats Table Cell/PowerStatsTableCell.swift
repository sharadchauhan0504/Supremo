//
//  PowerStatsTableCell.swift
//  Supremo
//
//  Created by Sharad on 16/11/20.
//

import UIKit

class PowerStatsTableCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBarContainerView: UIView! {
        didSet {
            let progressBar = LinearProgressBarView(frame: progressBarContainerView.bounds)
            progressBar.barColor = .warmPink
            progressBar.trackColor = .lightGray
            progressBar.progressValue = 75
            progressBarContainerView.addSubview(progressBar)
        }
    }
    
    //MARK:- Public variables
    var intelligence: String? = nil {
        didSet {
            setIntelligence()
        }
    }
    
    var strength: String? = nil {
        didSet {
            setStrength()
        }
    }
    
    var speed: String? = nil {
        didSet {
            setSpeed()
        }
    }
    
    var durability: String? = nil {
        didSet {
            setDurability()
        }
    }
    
    var power: String? = nil {
        didSet {
            setPower()
        }
    }
    
    var combat: String? = nil {
        didSet {
            setCombat()
        }
    }
    
    //MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressBarContainerView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    //MARK:- Private methods
    private func setIntelligence() {
        guard let data = intelligence else {return}
        titleLabel.text = "Intelligence"
        addProgressBar(Int(data) ?? 0)
    }
    
    private func setStrength() {
        guard let data = strength else {return}
        titleLabel.text = "Strength"
        addProgressBar(Int(data) ?? 0)
    }
    
    private func setSpeed() {
        guard let data = speed else {return}
        titleLabel.text = "Speed"
        addProgressBar(Int(data) ?? 0)
    }
    
    private func setDurability() {
        guard let data = durability else {return}
        titleLabel.text = "Durability"
        addProgressBar(Int(data) ?? 0)
    }
    
    private func setPower() {
        guard let data = power else {return}
        titleLabel.text = "Power"
        addProgressBar(Int(data) ?? 0)
    }
    
    private func setCombat() {
        guard let data = combat else {return}
        titleLabel.text = "Combat"
        addProgressBar(Int(data) ?? 0)
    }
    
    private func addProgressBar(_ progress: Int) {
        progressBarContainerView.subviews.forEach { $0.removeFromSuperview() }
        let progressBar           = LinearProgressBarView(frame: progressBarContainerView.bounds)
        progressBar.barThickness  = progressBarContainerView.bounds.height
        progressBar.barColor      = .warmPink
        progressBar.trackColor    = .lightGray
        progressBar.progressValue = CGFloat(progress)
        progressBarContainerView.addSubview(progressBar)
    }
}
