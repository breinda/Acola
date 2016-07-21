//
//  Step.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 20/07/16.
//  Copyright © 2016 Brenda Carrocino. All rights reserved.
//

import UIKit

struct Step {
    let name : String!
    let description : String!
    let index : String!
    
    init(index: String, snapshot: Dictionary<String,AnyObject>) {
        
        self.index = index
        
        self.name = snapshot["name"] as! String
        self.description = snapshot["description"] as! String
    }
    
    init(name: String, description: String, index: String) {
        
        self.index = index
        self.name = name
        self.description = description
    }
    
}