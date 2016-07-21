struct Goal {
    let name : String!
    let description : String!
    let steps : [Step]!
    
    init(name: String, description: String, steps: [Step]) {
        
        self.name = name
        self.description = description
        self.steps = steps
    }
    
}