//
//  ViewController.swift
//  Substitute Payment
//
//  Created by Emmett Duffy on 1/9/18.
//  Copyright © 2018 Vedant Iyer. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ViewController: UIViewController {//this is the login view controller that I dont feel like renaming

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var passwordTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().signIn(withEmail: "test_mail@gmail.com", password: "testing") { (user, error) in
        }
        loginButton.layer.cornerRadius = 10 // Set border radius (Make it curved, increase this for a more rounded button
        let goodfake = ["absence_reason": "trying to cop the new 1's", "department": "music", "date": "12-10-19", "teacher": "KanYeezy"]
        
        let formation = Database.database().reference(withPath: "/forms/second_id")
        let tf = Form(in_ref: formation)
        tf.append_subform(subform: goodfake)
        
        
        let jane = FormFilter(acc: "test_uid")
        jane.filter(key: "date", value: "12-13-17", completed: { (snapshot_arr) in
            
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
