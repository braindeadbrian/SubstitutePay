//
//  payeeFormViewController.swift
//  Substitute Payment
//
//  Created by Emmett Duffy on 1/9/18.
//  Copyright © 2018 Vedant Iyer. All rights reserved.
//


import UIKit

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
    
    let foods = ["Alabama", "Alaska", "Arizona", "Arkansas", "California","Colorado", "Connecticut", "Delaware", "Florida", "Georgia","Hawaii", "Idaho", "Illinois", "Indiana", "Iowa","Kansas", "Kentucky", "Louisiana", "Maine", "Maryland","Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri","Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey","New Mexico", "New York", "North Carolina", "Norht Dakota", "Ohio","Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina","South Dakota", "Tennessee", "Texas", "Utah", "Vermont","Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming",]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return foods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return foods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //label.text = foods[row] here is how to get the state that is picked cuase im doing to forget it
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        


        // Do any additional setup after loading the view, typically from a nib.
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
