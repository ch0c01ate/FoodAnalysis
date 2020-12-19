//
//  MealTableViewCell.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func setup() {
        contentView.backgroundColor = AppColors.grey
        cellView.backgroundColor = UIColor.white
        cellView.layer.cornerRadius = 12
        descriptionLabel.textColor = AppColors.royalBlue
        energyLabel.textColor = AppColors.royalBlue
        dataLabel.textColor = UIColor.lightGray
    }
    
    func configure(meal: Meal) {
        descriptionLabel.text = meal.text
        energyLabel.text = "\(meal.energy) kkal"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        dataLabel.text = formatter.string(from: meal.date)
    }
    
}
