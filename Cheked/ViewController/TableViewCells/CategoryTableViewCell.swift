//
//  CategoryTableViewCell.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 12.02.2023.
//

import UIKit
import SwipeCellKit

class CategoryTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var backgroundCard: UIView!
    @IBOutlet weak var categoryName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
