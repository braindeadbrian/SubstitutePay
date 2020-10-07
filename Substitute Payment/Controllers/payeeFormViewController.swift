//
//  payeeFormViewController.swift
//  Substitute Payment
//
//  Created by Emmett Duffy on 1/9/18.
//  Copyright © 2018 Vedant Iyer. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase
class payeeFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    
    @IBOutlet weak var subNameTextField: UITextField!
    
    @IBOutlet weak var homeAddressTextField: UITextField!
    
    @IBOutlet weak var teacherNameTextField: UITextField!
    
    @IBOutlet weak var numberOfDays: UITextField!
    
    @IBOutlet weak var datesSubTextField: UITextField!
    
    @IBOutlet weak var signatureTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var reasonTextField: UITextField!
    
    @IBOutlet weak var stateTextField: UITextField!
    
    let now = NSDate()
    
    var dep = ""
    let dateFormatter = DateFormatter()
    
    //let department = ["math", "science","english","music"]
    let department = ["upper school", "middle school", "lower school"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return department[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return department.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        dep = department[row]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
        //get the subname
        //try to get the home address
        dateFormatter.dateStyle = .short
        dateTextField.text = "\(dateFormatter.string(from: now as Date))"
        

        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func submitActionButton(_ sender: Any)
    
    {
        if(reasonTextField.text == "" && teacherNameTextField.text == "")
        
        {
            
            print("error")
            
        }
        
        else
        {
        print("submit")
//        let myString = dateFormatter.string(from: Date())
//        // convert your string to date
//        let yourDate = dateFormatter.date(from: myString)
//        //then again set the date format whhich type of output you need
//        dateFormatter.dateFormat = "dd-MMM-yyyy"
//        // again convert your date to string
//        let myStringafd = dateFormatter.string(from: yourDate!)
        
        let tf = Form(in_ref: "forms/Form_300")
        let goodfake = ["absence_reason": reasonTextField.text! , "department":  "math" , "date": "date", "teacher": teacherNameTextField.text! ]
        tf.append_subform(subform: goodfake)
        tf.put_substitute(uid: Auth.auth().currentUser!.uid)
        print("sumit")
        
//        let jane = FormFilter(acc: "test_uid")
//        jane.filter(key: "date", value: "12-13-17", completed: { (snapshot_arr) in
        }
        }
        
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}
