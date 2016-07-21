//
//  Goal.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 18/07/16.
//  Copyright © 2016 Brenda Carrocino. All rights reserved.
//

import UIKit

struct Goal {
    let key : String!
    let name : String!
    let description : String!
    let firstStep : Step!
    
    init(key: String, snapshot: Dictionary<String,AnyObject>) {
        self.key = key
        self.name = snapshot["name"] as! String
        self.description = snapshot["description"] as! String
        
        let firstStepDic = snapshot["firstStep"] as! [String : String]
        
        let nameStep = firstStepDic["name"]
        let descStep = firstStepDic["description"]
        let indStep = "one"
        
        self.firstStep = Step(name: nameStep!, description: descStep!, index: indStep, isLastStep: false)
    }
    
}