//
//  AddCategoryTableViewCell.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 14.02.2023.
//

import UIKit
import Hero

class AddCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var addCategoryLabel: UILabel!
    @IBOutlet weak var backgroundCard: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
