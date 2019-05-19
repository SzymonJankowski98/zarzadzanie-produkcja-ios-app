//
//  cellZamontujNarzedzie.swift
//  aplikacja2
//
//  Created by m2dev on 16.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class cellZamontujNarzedzie: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var nr_gniazda: UILabel!
    @IBOutlet weak var info_image: UIImageView!
    @IBOutlet weak var nazwa_plytki: UILabel!
    @IBOutlet weak var opis: UILabel!
    @IBOutlet weak var ilosc_ostrzy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
