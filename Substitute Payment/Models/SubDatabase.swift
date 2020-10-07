//
//  SubDatabase.swift
//  Substitute Payment
//
//  Created by Mason Llewellyn on 2/5/18.
//  Copyright © 2018 Vedant Iyer. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class SubDatabase: NSObject{
    var ref = DatabaseReference()
    init(in_ref: DatabaseReference){
        ref = in_ref
    }
    func new_form(){
        
    }
    
    func update_form(){
        
    }
    func get_satisfying(key: String, value: String, completed: @escaping ([DataSnapshot]) -> Void){
        //var op = DataSnapshot()
        var op = [DataSnapshot]()
        //this is a closure, this executes async, figure out how to get this as async or some other workaround
        ref.observe(.value, with: {snapshot in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let k = snap.childSnapshot(forPath: key)
                if k.value! as! String == value{
                    //op = snap
                    op.append(snap)
                    //print(snap.value!)
                }
                
            }
            completed(op)
        });
    }
}
