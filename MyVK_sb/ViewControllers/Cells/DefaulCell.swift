//
//  DefaulCell.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import UIKit
import Kingfisher

// MARK: - DefaulCell

class DefaulCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var circleShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // MARK: - Configure
    
    public func configure(for object: AnyObject) {
        switch object {
        case let friend as Friend:
            nameLabel.text = friend.firstName + " " + friend.lastName
            avatarImage.kf.setImage(with: URL(string: friend.photo))
        case let group as Group:
            nameLabel.text = group.name
            avatarImage.kf.setImage(with: URL(string: group.photo))
        default: break
        }
        circleShadow.layer.backgroundColor = UIColor.clear.cgColor
    }
}
