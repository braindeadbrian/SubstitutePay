//
//  Form.swift
//  Substitute Payment
//
//  Created by Mason Llewellyn on 2/10/18.
//  Copyright © 2018 Vedant Iyer. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Form: NSObject{
    //each sub form should be it's own dictionary like JSON
    var subForms = [[String: String]()]
    var sub_teacher = [String: String]()
    var ref = DatabaseReference()
    let sub_dir = Database.database().reference(withPath: "substituteteachers")
    override init(){
        super.init()
        print("spillage village")
        self.ref = Database.database().reference(withPath: "forms/form_id_number")
        //self.download_subforms()
        
        //self.download_substitute()
    }
    init(in_ref: String){
        super.init()
        self.ref = Database.database().reference(withPath: in_ref)
        self.download_subforms()
        
        self.download_substitute()
    }
    //this takes in the location of the form at the form ID
    func append_subform(subform: [String: String]){
        print("appending the subform")
        get_numgen(completionHandler: { (id_num) in
            let naam = subform["date"]! + "x" + subform["teacher"]!
            let base_ref = Database.database().reference(withPath: "forms/Form_" + String(describing: id_num))
            let specific = base_ref.child(naam)
            base_ref.child("substitute").setValue(subform["substitute"])
            
            for (key, value) in subform{
                print("hmmm....")
                specific.child(key).setValue(value)
            }
            
        })
        
    }
    func get_numgen(completionHandler: @escaping (String) -> Void){
        let ref = Database.database().reference(withPath: "form_num_gen")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let num = snapshot.value as! Int
            
            completionHandler(String(describing: num))
        })
    }
    func put_substitute(uid: String){
        print("updating substitute")
        let specific = self.ref.child("substitute")
        specific.setValue(uid)
    }
    func download_substitute(){
        
        let sub_id_ref = self.ref.child("substitute")
        print("damn")
        var sub_id:String = "";
        //the async problem again... the id_ref isn't complete when the other sub ref is still running
        sub_id_ref.observeSingleEvent(of: .value, with: { (snapshot) in
            sub_id = snapshot.value as! String
            print("the neighbors think I'm sellin' DOPE")
            print(sub_id)
            let info_ref = self.sub_dir.child(sub_id)
            info_ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                for child in snapshot.children{
                    let snap = child as! DataSnapshot
                    self.sub_teacher[snap.key] = String(describing: snap.value!)
                }
                print(self.sub_teacher)
            })
            
        })
        
        
    }
    func download_subforms(completionHandler: @escaping ([[String: String]]) -> Void){
        print("still ain't this!")
        self.ref.observe(.value, with: { snapshot in
            var count = 0
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                var tmp = [String: String]()
                for gen in snap.children{
                    let snen = gen as! DataSnapshot
                    tmp[snen.key] = String(describing: snen.value!);
                }
                self.subForms.append(tmp)
                count += 1
                //self.subForms[snap.key] = String(describing: snap.value!)
            }
            //the actual data starts at index 1 for some reason, looking into that
            self.subForms = self.subForms.filter {$0 != [:]}
            print(self.subForms)
            completionHandler(self.subForms)
            
        });
    }
    func download_substitute(completionHandler: @escaping (String) -> Void){
        
        let sub_id_ref = self.ref.child("substitute")
        print("damn")
        var sub_id:String = "";
        //the async problem again... the id_ref isn't complete when the other sub ref is still running
        sub_id_ref.observeSingleEvent(of: .value, with: { (snapshot) in
            sub_id = snapshot.value as! String
            print("the neighbors think I'm sellin' DOPE")
            
            let info_ref = self.sub_dir.child(sub_id)
            info_ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                for child in snapshot.children{
                    let snap = child as! DataSnapshot
                    self.sub_teacher[snap.key] = String(describing: snap.value!)
                }
                print(self.sub_teacher)
                completionHandler(sub_id)
            })
            
            
        })
        
        
        
    }
    func download_subforms(){
        print("still ain't this!")
        self.ref.observe(.value, with: { snapshot in
            var count = 0
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                var tmp = [String: String]()
                for gen in snap.children{
                    let snen = gen as! DataSnapshot
                    tmp[snen.key] = String(describing: snen.value!);
                }
                self.subForms.append(tmp)
                count += 1
                //self.subForms[snap.key] = String(describing: snap.value!)
            }
            //the actual data starts at index 1 for some reason, looking into that
            self.subForms = self.subForms.filter {$0 != [:]}
            print(self.subForms)
        });
    }
}

