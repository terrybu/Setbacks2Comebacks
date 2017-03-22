//
//  FontSizeTableViewCell.swift
//  TaoTeChingSwift
//
//  Created by David Weissler on 10/30/16.
//  Copyright © 2016 Bogil, John. All rights reserved.
//

import UIKit

class FontSizeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
