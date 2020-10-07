//
//  InvoiceComposer.swift
//  Substitute Payment
//
//  Created by Vedant Iyer on 2/22/18.
//  Copyright © 2018 Vedant Iyer. All rights reserved.
//

import UIKit
import MessageUI

class InvoiceComposer: NSObject {
    
    let pathToInvoiceHTMLTemplate = Bundle.main.path(forResource: "invoice", ofType: "html")
    
    let pathToSingleItemHTMLTemplate = Bundle.main.path(forResource: "single_item", ofType: "html")
    
    let pathToLastItemHTMLTemplate = Bundle.main.path(forResource: "last_item", ofType: "html")
    
    let subName = "Gabriel Theodoropoulos"
    let subAddress = "123 Somewhere Str."
    let cityAndZip = "City, State, 00000"
    
    let formInstructions = "This form is to request a payroll check for Substitute Teaching."
    
    let logoImageURL = "https://pbs.twimg.com/profile_images/718143261500571649/EyhNENa1_400x400.jpg"
    
    let datesMethod = "10"
    
    let stringArray = ["1/2", "1/10", "1/23", "1/20", "1/100", "1/230", "1/233", "1/1033", "1/2333"]
    
    var teacherArray = ["Joe", "Paul", "John"]
    
    let reasonArray = ["Death", "Sick", "Pro Day"]
    
    //let Form = form
    
    var pdfFilename: String!
    
    init(_ FORM: Form)
    {
        super.init()
        var form = FORM
        form.download_substitute(completionHandler: { (subforms) in
            let sauce = subforms
            
            print("teacherArray: " + String(describing: subforms))
        })
    }
    
    func getDate()-> String
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: date)
    }
    
    func subSignature(_ name: String, _ date: String) -> String
    {
        return name + date
    }
    
    
    func renderInvoice() -> String! {
        // Store the invoice number for future use.
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO_IMAGE#", with: logoImageURL)
            
            // Invoice date.
            //HTMLContent = HTMLContent.replacingOccurrences(of: "#INVOICE_DATE#", with: invoiceDate)
            
            // Current date
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CURRENT_DATE#", with: getDate())
            
            // Sub Name
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SUB_NAME#", with: subName)
            
            // Sub Address
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SUB_ADDRESS#", with: subAddress)
            
            // Payee City/Zip
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CITY_ZIP#", with: cityAndZip)
            
            // Dates Worked
            HTMLContent = HTMLContent.replacingOccurrences(of: "#DATES_WORKED#", with: stringArray.joined(separator: ", "))
            
            // Recipient info.
            //            HTMLContent = HTMLContent.replacingOccurrences(of: "#RECIPIENT_INFO#", with: recipientInfo.replacingOccurrences(of: "\n", with: "<br>"))
            
            // Payment method.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#INSTRUCTIONS#", with: formInstructions)
            
            // Days Worked.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#NUM_DAYS#", with: datesMethod)
            
            // Sub Signature
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SUB_SIGN#", with: subSignature("bob", "2/15/2018"))
            
            // Total amount.
            //HTMLContent = HTMLContent.replacingOccurrences(of: "#TOTAL_AMOUNT#", with: totalAmount)
            
            // The invoice items will be added by using a loop.
            var allItems = ""
            
            // For all the items except for the last one we'll use the "single_item.html" template.
            // For the last one we'll use the "last_item.html" template.
            for i in 0..<teacherArray.count
            {
                var itemHTMLContent: String!
                
                // Determine the proper template file.
                if i != teacherArray.count - 1
                {
                    itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
                }
                else
                {
                    itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
                }
                
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#TEACHER#", with: teacherArray[i])
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#REASON#", with: reasonArray[i])
                
                // Add the item's HTML code to the general items string.
                allItems += itemHTMLContent
            }
            
            // Set the items.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ITEMS#", with: allItems)
            
            // The HTML code is ready.
            return HTMLContent
            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Invoice\(subName).pdf"
        pdfData?.write(toFile: pdfFilename, atomically: true)
        
        print(pdfFilename)
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
    
    //    func showPdf()
    //    {
    //        var pdfURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
    //        print("check final = \(pdfURL)")
    //        pdfURL = pdfURL.appendingPathComponent(pdfFilename) as URL
    //
    //        do{
    //            let result = try getPdf()
    //            print (result)
    //        }
    //        catch let error as NSError
    //        {
    //            print("An error took place: \(error)")
    //        }
    //    }
    //
    //
    //    func getPdf() throws -> String
    //    {
    //        //let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    //        //let url = URL(fileURLWithPath: path)
    //        //var filePath = appendingPathComponent(pdfFilename)
    //        let fileManager1 = FileManager.default
    //        if fileManager1.fileExists(atPath: pdfFilename)
    //        {
    //            print("FILE AVAILABLE in VC")
    //            // let fileUrlkk = NSURL(string: filePath)// converting string into URL
    //
    //            //filePath = "file://\(filePath)"
    //
    //        }
    //        else
    //        {
    //            print("FILE NOT AVAILABLE in VC")
    //            return "FILE NOT AVAILABLE in VC"
    //        }
    //        return "FILE FOUND"
    //    }
    
}

