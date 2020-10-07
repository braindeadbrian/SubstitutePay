//
//  User.swift
//  SubstitutePlayground
//
//  Created by Varun Kadikar on 1/8/18.
//  Copyright © 2018 Varun Kadikar. All rights reserved.
//

import UIKit

class User: NSObject
{
    var name = ""
    var datesWorked: [Date] = []
    var daysWorked = 0
    var country = ""
    var state = ""
    var city = ""
    var zipCode = ""
    var street = ""
    var houseNumber = ""
    var suiteNumber = ""
    var substitutedFor = ""
    var eSignature = ""
    
    
    //saved forms
    //var priorForms: [Form] = []
    
    
    init(nam: String, dates: [Date],cntry: String, st: String, cit: String, zip: String, strt: String, house: String, suite: String, subbedFor: String, eSig: String)
    {
        self.name = nam
        self.datesWorked = dates
        self.daysWorked = datesWorked.count
        self.country = cntry
        self.state = st
        self.city = cit
        self.zipCode = zip
        self.street = strt
        self.houseNumber = house
        self.suiteNumber = suite
        self.substitutedFor = subbedFor
        self.eSignature = eSig
    }
    
    //setter methods
    
    func setDatesWorked(dates: [Date])
    {
        var i = 0
        
        while(i < dates.count)
        {
            datesWorked.append(dates[i])
            i+=1
        }
    }
    
    func setDaysWorked(days: Int)
    {
        daysWorked = days
    }
    
    func setSubstitutedFor(subbedFor: String)
    {
        substitutedFor = subbedFor
    }
    
    func setAddress(country: String, state: String, city: String, zip: String, street: String, houseNum: String, suiteNum: String)
    {
        self.country = country
        self.state = state
        self.city = city
        self.zipCode = zip
        self.street = street
        self.houseNumber = houseNum
        self.suiteNumber = suiteNum
    }
}

