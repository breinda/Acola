//
//  Phone.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 08/07/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

struct Phone {
    let name : String!
    let description : String!
    let number : String!
    let index : String!
    
    init(index: String, snapshot: Dictionary<String,AnyObject>) {
        
        self.index = index
        
        self.name = snapshot["name"] as! String
        self.description = snapshot["description"] as! String
        self.number = snapshot["number"] as! String
    }
    
    init(name: String, description: String, index: String, number: String) {
        
        self.index = index
        self.name = name
        self.description = description
        self.number = number
    }
    
}
