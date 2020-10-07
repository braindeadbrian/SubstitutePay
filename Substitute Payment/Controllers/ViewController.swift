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
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var admin = false
    
    @IBAction func loginAction(_ sender: Any)
    
    {
        
   
        Auth.auth().signIn(withEmail: username.text!, password: password.text! ){ (user, error) in
            if (error == nil) {
                    self.performSegue(withIdentifier: "login", sender: self)
            }
            if (error != nil){
                let alert = UIAlertView()
                alert.title = "Login Error"
                alert.message = "Login Failed.  Either the username or password is incorrect."
                alert.addButton(withTitle: "Okay")
                alert.show()
                print("there is an error")
            }
          
            
          
            
        }

        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.isSecureTextEntry = true
        
        loginButton.layer.cornerRadius = 10 // Set border radius (Make it curved, increase this for a more rounded button
       
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
