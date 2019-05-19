//
//  cellMaszyny.swift
//  aplikacja2
//
//  Created by m2dev on 29.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class cellMaszyny: UITableViewCell {
    
    @IBOutlet weak var nazwa: UILabel!
    @IBOutlet weak var opis: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
