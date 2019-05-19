//
//  maszynyDodaj.swift
//  aplikacja2
//
//  Created by m2dev on 07.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class maszynyDodaj: UIViewController {
    
    @IBOutlet weak var nazwa: UITextField!
    @IBOutlet weak var opis: UITextField!
    @IBOutlet weak var gniazda: UITextField!
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func dodaj(sender: AnyObject) {
        var zapisz_maszyna = zapisz()
        var g = gniazda.text!
        //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
        //self.navigationController?.pushViewController(view, animated: true)
        let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("VC2")
        if (Int(g) == nil || Int(g)<0)
        {
            label.text = "nieprawidłowa ilość gniazd"
            return
        }
        
        let path = "http://localhost/maszyny_zapisz.php"
        let zapytanie = "a=INSERT INTO `apk`.`maszyny` (`ID_maszyny`,`nazwa`,`opis`,`ilosc_gniazd`) VALUES (NULL,'\(nazwa.text!)','\(opis.text!)','\(gniazda.text!)');&b=\(gniazda.text!)"
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
