//
//  DefaulCell.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import UIKit

class DefaulCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var circleShadow: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
