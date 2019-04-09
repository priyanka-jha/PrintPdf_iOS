//
//  PdfViewController.swift
//  PrinPdf
//
//  Created by Megavision Technologies on 09/04/19.
//  Copyright © 2019 Megavision Technologies. All rights reserved.
//

import UIKit
import MessageUI

class PdfViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var pdfWebView: UIWebView!
    
    var (name,email,pwd) = ("", "", "")
    var pdfElements: PdfElements!
    
    var HTMLContent: String!
    var pdfFilename: String!
    var filename = "",text_message=""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(name,email,pwd)
       
        let image : UIImage = UIImage(named: "logo")!
        
        // let imageData:NSData = image.pngData()! as NSData
        let  imageData:NSData = image.jpegData(compressionQuality: 0)! as NSData    //compress the image
        var image_str = imageData.base64EncodedString(options: .lineLength64Characters)
        
        pdfElements = PdfElements()
        if var bldgHTML = pdfElements.renderPdf(name: name, email: email, pwd: pwd, logoimage: image_str) {
            
            pdfWebView.loadHTMLString(bldgHTML, baseURL: NSURL(string: pdfElements.pathToHTMLTemplate!)! as URL)
            HTMLContent = bldgHTML
            
            
            exportHTMLContentToPDF(HTMLContent: bldgHTML)
            
            
        }
        
        
    }
    
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print("documentsPath..",documentsPath)
        
        pdfFilename = "\(documentsPath)/\("iOS_PRint").pdf"
     
        pdfData?.write(toFile: pdfFilename, atomically: true)
        print("pdf created")
        
        
    
    }
    
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        for i in 0..<printPageRenderer.numberOfPages {
            UIGraphicsBeginPDFPage()
            printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext()
        
        return data
    }
    

    @IBAction func sendEmail(_ sender: Any) {
        if( MFMailComposeViewController.canSendMail() )
            
        {
            
            text_message = "Hi" + ",</br>" + "</br></br>Please find attached pdf file." + "</br></br>Regards,</br>"
            + "User" + "</br>"
        
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        //Set to recipients
        mailComposer.setToRecipients(["abcd@gmail.com"])
        
        //Set the subject
        mailComposer.setSubject("Pdf File")
        
        //set mail body
        mailComposer.setMessageBody(text_message, isHTML: true)
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
    
        let pathPDF = "\(documentsPath)/\("iOS_PRint").pdf"
        print("pathPDF..",pathPDF)
        
        if let fileData = NSData(contentsOfFile: pathPDF)
        {
            print("File data loaded.")
            mailComposer.addAttachmentData(fileData as Data, mimeType: "application/pdf", fileName: "\("iOS_PRint").pdf")
        }
        
        //this will compose and present mail to user
        self.present(mailComposer, animated: true, completion: nil)
    }
    else
    {
    print("email is not supported")
    }
    
    func mailComposeController(_ didFinishWithcontroller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
