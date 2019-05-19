//
//  cellZamontujPlytke.swift
//  aplikacja2
//
//  Created by m2dev on 27.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class cellZamontujPlytke: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nazwa: UILabel!
    @IBOutlet weak var info_image: UIImageView!
    @IBOutlet weak var ilosc_ostrzy: UILabel!
    @IBOutlet weak var opis: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}