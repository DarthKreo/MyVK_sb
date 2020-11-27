//
//  NewsCell.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 05.11.2020.
//

import UIKit

// MARK: - NewsCell

class NewsCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLikes: LikeControl!
    @IBOutlet weak var newsCmmnts: UIButton!
    @IBOutlet weak var newsShare: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
