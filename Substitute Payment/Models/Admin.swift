//
//  Admin.swift
//  Admin
//
//  Created by Zach Osman on 1/22/18.
//  Copyright © 2018 Zach Osman. All rights reserved. hi
//

import UIKit
//import MessageUI

class Admin: NSObject {
    
    var AdminID:Int
    var first_name:String
    var last_name:String
    var Forms = [Form]()
    //PDF = Forms[index].createPDF()
    //emailPDF
    //sendToBO
    
    
    init(_ ID:Int, _ firstName:String, _ lastName:String) {
        self.AdminID = ID
        self.first_name = firstName
        self.last_name = lastName
        super.init()
        self.Forms = getForms_Firebase()
    }
    
    public func deny_form(index:Int){
        //        Forms[index].setStatus(0)
        updateFirebase(array: Forms)
    }
    
    public func approve_form(index:Int, new_Form:Form){
        Forms[index] = new_Form
        //        Forms[index].setStatus(1)
        updateFirebase(array: Forms)
    }
    
    public func edit_Form(index:Int, new_Form:Form){
        Forms[index] = new_Form
        updateFirebase(array: Forms)
    }
    
    private func updateFirebase(array:[Form]){
        //CALL FIREBASE CLASS METHOD
        // "FIREBASE METHOD" with array
        
    }
    
    public func getForms_Firebase() -> [Form]{
        //CALL FIREBASE CLASS METHOD
        //Forms = "FIREBASE METHOD"
        return []
    }
    
    //BO Office
    
    public func sendEmail()
    {
        //Check to see the device can send email.
        //        if( MFMailComposeViewController.canSendMail() ) {
        //            println("Can send email.")
        //
        //            let mailComposer = MFMailComposeViewController()
        //            mailComposer.mailComposeDelegate = self
        //
        //            //Set the subject and message of the email
        //            mailComposer.setSubject("Have you heard a swift?")
        //            mailComposer.setMessageBody("This is what they sound like.", isHTML: false)
        //
        //            if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "pdf") {
        //                println("File path loaded.")
        //
        //                if let fileData = NSData(contentsOfFile: filePath) {
        //                    println("File data loaded.")
        //                    mailComposer.addAttachmentData(fileData, mimeType: "audio/wav", fileName: "swifts")
        //                }
        //            }
        //            self.presentViewController(mailComposer, animated: true, completion: nil)
        //        }
        //    }
        //
        //    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        //        self.dismissViewControllerAnimated(true, completion: nil)
        //    }
    }
    
    public func sendToBO(index: Int)
    {
        
        updateFirebase(array: Forms)
    }
    
    
    
    
}


