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
    
    init(name: String, description: String, index: String) {
        
        self.name = name
        self.description = description
        self.index = index
    }
    
}