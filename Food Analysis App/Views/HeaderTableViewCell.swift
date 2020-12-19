//
//  HeaderTableViewCell.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }

    func setup() {
        contentView.backgroundColor = AppColors.grey
        cellView.layer.cornerRadius = 12
    }
    
    func setupText(text: String) {
        cellTitle.text = text
    }
    
}
