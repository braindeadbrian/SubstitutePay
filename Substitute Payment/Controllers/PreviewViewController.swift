//
//  PreviewViewController.swift
//  Substitute Payment
//
//  Created by Vedant Iyer on 2/22/18.
//  Copyright © 2018 Vedant Iyer. All rights reserved.
//

import UIKit
import MessageUI


class PreviewViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var webPreview: UIWebView!
    
    var invoiceInfo: [String: AnyObject]!
    
    var invoiceComposer: InvoiceComposer!
    
    var HTMLContent: String!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //createInvoiceAsHTML()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: IBAction Methods
    
    //Click button--> email screen shows up
    @IBAction func exportToPDF(_ sender: AnyObject) {
        invoiceComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
        sendEmail()
        //        showOptionsAlert()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendEmail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.setSubject("Sub Form")
            mailComposeViewController.setToRecipients(["iyerv@rutgersprep.org"])
            mailComposeViewController.addAttachmentData(NSData(contentsOfFile: invoiceComposer.pdfFilename)! as Data, mimeType: "application/pdf", fileName: "Sub Form")
            mailComposeViewController.mailComposeDelegate = self
            present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: Custom Methods
    
    func createInvoiceAsHTML(in_form: Form) {
        invoiceComposer = InvoiceComposer(in_form)
        if let invoiceHTML = invoiceComposer.renderInvoice() {
            webPreview.loadHTMLString(invoiceHTML, baseURL: NSURL(string: invoiceComposer.pathToInvoiceHTMLTemplate!)! as URL)
            HTMLContent = invoiceHTML
        }
    }
    
    
    
    //    func showOptionsAlert() {
    //        let alertController = UIAlertController(title: "Yeah!", message: "Your invoice has been successfully printed to a PDF file.\n\nWhat do you want to do now?", preferredStyle: UIAlertControllerStyle.alert)
    //
    //        let actionPreview = UIAlertAction(title: "Preview it", style: UIAlertActionStyle.default) { (action) in
    //            if let filename = self.invoiceComposer.pdfFilename, let url = URL(string: filename) {
    //                let request = URLRequest(url: url)
    //                self.webPreview.loadRequest(request)
    //            }
    //        }
    //
    //        let actionEmail = UIAlertAction(title: "Send by Email", style: UIAlertActionStyle.default) { (action) in
    //            DispatchQueue.main.async {
    //                self.sendEmail()
    //            }
    //        }
    //
    //        let actionNothing = UIAlertAction(title: "Nothing", style: UIAlertActionStyle.default) { (action) in
    //
    //        }
    //
    //        alertController.addAction(actionPreview)
    //        alertController.addAction(actionEmail)
    //        alertController.addAction(actionNothing)
    //
    //        present(alertController, animated: true, completion: nil)
    //    }
    
}

