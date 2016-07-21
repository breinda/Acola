//
//  User.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 21/07/16.
//  Copyright © 2016 Brenda Carrocino. All rights reserved.
//

import UIKit

struct User {
    let key : String!
    let name : String!
    let petName: String!
    let currentGoalKey: String!
    let currentStepNumber: String!
    //let customGoals: [Goal]!
    let customGoals: Bool!
    
    init(key: String, snapshot: Dictionary<String,AnyObject>) {
        self.key = key
        self.name = snapshot["name"] as! String
        self.petName = snapshot["petName"] as! String
        self.currentGoalKey = snapshot["currentGoalKey"] as! String
        self.currentStepNumber = snapshot["currentStepNumber"] as! String
        self.customGoals = snapshot["customGoals"] as! Bool
        
//        let customGoalsDic = snapshot["customGoals"] as! [String : [String: String]]
//        
//        let nameStep = firstStepDic["name"]
//        let descStep = firstStepDic["description"]
//        let indStep = "one"
//        
//        self.firstStep = Step(name: nameStep!, description: descStep!, index: indStep, isLastStep: false)
    }
    
}