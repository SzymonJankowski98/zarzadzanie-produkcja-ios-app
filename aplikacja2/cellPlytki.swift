//
//  cellPlytki.swift
//  aplikacja2
//
//  Created by m2dev on 21.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class cellPlytki: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switch_zuzycie: UISwitch!
    @IBOutlet weak var ilosc_text: UITextField!
    @IBOutlet weak var ilosc_stepper: UIStepper!
    
    
 override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
