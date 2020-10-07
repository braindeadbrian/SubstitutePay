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
        self.download_subforms()
        
        self.download_substitute()
        
    }
    init(in_ref: DatabaseReference){
        super.init()
        //need to create some default databse references if they don't exist
        self.ref = in_ref
        self.download_subforms()
        
        self.download_substitute()
    }
    //this takes in the location of the form at the form ID
    func append_subform(subform: [String: String]){
        let naam = subform["date"]! + "x" + subform["teacher"]!
        let specific = self.ref.child(naam)
        for (key, value) in subform{
            specific.child(key).setValue(value)
        }
    }
    func download_substitute(){
        
        let sub_id_ref = self.ref.child("substitute")
        print("damn")
        var sub_id:String = "";
        sub_id_ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //allows for references to nothing to be submitted and new forms to be created
            if let sub_id = snapshot.value as? String {
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
            }
            else{
                //no_value is the default for any reference in the database that hasn't been filled in
                let def = "no_value"
                let attrs = ["admin_signature", "admin_rejected", "date_submitted", "substitute"]
                for i in attrs{
                    self.ref.child(i).setValue(def)
                }
            }
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
            //print(self.subForms)
        });
    }
}
