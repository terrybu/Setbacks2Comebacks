//
//  HomeTableViewCell.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/28/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var personFaceImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
