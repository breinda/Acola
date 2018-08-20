struct Goal {
    let key : String!
    let name : String!
    let description : String!
    let firstStep : Step!
    let isCustom : Bool!
    
    init(key: String, isCustom: Bool, snapshot: Dictionary<String,AnyObject>) {
        self.key = key
        self.name = snapshot["name"] as! String
        self.description = snapshot["description"] as! String
        self.isCustom = isCustom
        
        let firstStepDic = snapshot["firstStep"] as! [String : String]
        
        let nameStep = firstStepDic["name"]
        let descStep = firstStepDic["description"]
        let indStep = "one"
        
        self.firstStep = Step(name: nameStep!, description: descStep!, index: indStep, isLastStep: false)
    }
    
}
