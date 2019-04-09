//
//  ViewController.swift
//  PrinPdf
//
//  Created by Megavision Technologies on 09/04/19.
//  Copyright © 2019 Megavision Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textNAme: UITextField!
   
    @IBOutlet weak var textEmail: UITextField!
    
    @IBOutlet weak var textPwd: UITextField!
    
    var name = "",email = "", pwd = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
    }

    @IBAction func printPdf(_ sender: Any) {
      
        name = textNAme.text ?? " "
        email = textEmail.text ?? " "
        pwd = textPwd.text ?? " "
        
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "PdfViewController") as! PdfViewController
        DV.name = name
        DV.email = email
        DV.pwd = pwd
        
        self.navigationController?.pushViewController(DV, animated: true)
        
        
    }
    
}

