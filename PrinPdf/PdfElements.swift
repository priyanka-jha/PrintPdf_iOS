//
//  PdfElements.swift
//  PrinPdf
//
//  Created by Megavision Technologies on 09/04/19.
//  Copyright © 2019 Megavision Technologies. All rights reserved.
//

import UIKit

class PdfElements: NSObject {
   
    let pathToHTMLTemplate = Bundle.main.path(forResource: "pdfpage", ofType: "html")
    var pdfFilename: String!
    var imagepath = "https://cdn0.iconfinder.com/data/icons/web-social-and-folder-icons/512/iOS.png"
    
    override init() {
        super.init()
    }
    
    
    func renderPdf( name: String, email: String, pwd: String, logoimage:String) -> String! {
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToHTMLTemplate!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO_IMAGE#", with: logoimage )
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#NAME#", with: name)
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#EMAIL#", with: email)
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#PWD#", with: pwd)
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#IOS_IMAGE#", with: imagepath )
            
            
            // The HTML code is ready.
            return HTMLContent
            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
    

}
