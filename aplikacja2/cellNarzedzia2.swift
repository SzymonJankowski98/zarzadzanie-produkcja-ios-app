//
//  cellNarzedzia2.swift
//  aplikacja2
//
//  Created by m2dev on 12.09.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class cellNarzedzia2: UITableViewCell {
    
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var nazwa: UILabel!
    @IBOutlet weak var nr_gniazda: UILabel!
    @IBOutlet weak var info_image: UIImageView!
    @IBOutlet weak var nazwa_plytki: UILabel!
    @IBOutlet weak var opis: UILabel!
    @IBOutlet weak var ilosc_ostrzy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
