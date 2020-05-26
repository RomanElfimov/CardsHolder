//
//  CardCell.swift
//  CardsHolder
//
//  Created by Рома on 25.01.2020.
//  Copyright © 2020 Рома. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var imageCard: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var phoneName: UILabel!
    
    
    //MARK: - override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCard.layer.cornerRadius = imageCard.frame.size.width / 2
        imageCard.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
