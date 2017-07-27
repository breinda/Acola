struct Step {
    let name : String!
    let description : String!
    let index : String!
    var isLastStep: Bool!
    
    init(index: String, snapshot: Dictionary<String,AnyObject>) {
        
        self.index = index
        
        self.name = snapshot["name"] as! String
        self.description = snapshot["description"] as! String
        self.isLastStep = snapshot["isLastStep"] as! Bool
    }
    
    init(name: String, description: String, index: String, isLastStep: Bool) {
        
        self.index = index
        self.name = name
        self.description = description
        self.isLastStep = isLastStep
    }
    
}
