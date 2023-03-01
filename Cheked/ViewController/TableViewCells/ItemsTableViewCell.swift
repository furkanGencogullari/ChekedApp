//
//  ItemsTableViewCell.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 12.02.2023.
//

import UIKit
import SwipeCellKit

class ItemsTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var backgroundCard: UIView!
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
