//
//  plytkaDodaj.swift
//  aplikacja2
//
//  Created by m2dev on 14.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation
import UIKit

class plytkaDodaj: UIViewController {
    
    @IBOutlet weak var nazwa: UITextField!
    @IBOutlet weak var opis: UITextField!
    @IBOutlet weak var producent: UITextField!
    @IBOutlet weak var ilosc: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func dodaj(sender: AnyObject) {
        var zapisz_maszyna = zapisz()
        var g = ilosc.text!
        //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
        //self.navigationController?.pushViewController(view, animated: true)
        let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("VC4")
        if (Int(g) == nil || Int(g)<0)
        {
            label.text = "nieprawidłowa ilość płytek"
            return
        }
        
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let dzisiaj = dateFormater.stringFromDate(NSDate())
        
        let path = "http://localhost/plytki_zapisz.php"
        let zapytanie = "a=INSERT INTO `apk`.`plytki` (`ID_plytki`,`nazwa`,`opis`,`ilosc_ostrzy`,`Producent`,`Data`,`Data_zamontowania`) VALUES (NULL,'\(nazwa.text!)','\(opis.text!)','\(ilosc.text!)','\(producent.text!)','\(dzisiaj)','\(dzisiaj)');&b=\(ilosc.text!)"
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
