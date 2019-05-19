//
//  narzedzieDodaj2.swift
//  aplikacja2
//
//  Created by m2dev on 13.09.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation
import UIKit

class narzedziaDodaj2: UIViewController {
    
    @IBOutlet weak var nazwa: UITextField!
    @IBOutlet weak var opis: UITextField!
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func dodaj(sender: AnyObject) {
        var zapisz_maszyna = zapisz()
        //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
        //self.navigationController?.pushViewController(view, animated: true)
        let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("narzedzia")
        let path = "http://localhost/narzedzia_zapisz.php"
        let zapytanie = "a=INSERT INTO `apk`.`narzedzia` (`ID_narzedzia`,`nazwa`,`opis`,`ID_plytki`) VALUES (NULL,'\(nazwa.text!)','\(opis.text!)',NULL);"
        print(zapytanie)
        zapisz_maszyna.zapisz(zapytanie, url: path)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
