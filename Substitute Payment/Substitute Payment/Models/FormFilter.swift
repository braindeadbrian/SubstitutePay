//
//  FormFilter.swift
//  Substitute Payment
//
//  Created by Mason Llewellyn on 2/13/18.
//  Copyright © 2018 Vedant Iyer. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FormFilter: NSObject{
    let form_ref = Database.database().reference(withPath: "forms")
    var account_id: String = ""
    var department: String = ""
    init(acc: String){
        super.init()
        self.account_id = acc
        let admin_ref = Database.database().reference(withPath: "administrators/" + acc + "/department")
        //this runs async
        admin_ref.observeSingleEvent(of: .value, with: { (snapshot) in
            self.department = String(describing: snapshot.value)
        })
        
    }
    func filter(key: String, value: String, completed: @escaping ([DataSnapshot]) -> Void){
        //this should filter for department as well as for the desired key value
        //should return a list of database references
        
        
        
        form_ref.observe(.value, with: { (snapshot) in
            for child in snapshot.children{
                let snp = child as! DataSnapshot
                for ctwo in snp.children{
                    let sop = ctwo as! DataSnapshot
                    var dep_t = false
                    for i in sop.children{
                        let j = i as! DataSnapshot
                        if(j.key == "department" && String(describing: j.value!) == "math"){
                            print("babyface")
                            dep_t = true
                        }
                        print(j.key + " : " + String(describing: j.value!))
                        if(dep_t){
                            print("damn")
                        }
                        if(j.key == key && String(describing: j.value!) == value && dep_t){
                            print("my mans, my mans")
                        }
                    }
                    //go one layer deeper
                }
            }
        });
    }
    
}
