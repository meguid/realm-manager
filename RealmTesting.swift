//
//  RealmTest.swift
//  Created by meguid
//

class RealmTesting {
    
    var realmManager : RealmManager = RealmManager()
    
    var children : [ChildUser] = [ChildUser]()
    var cachedChildren : [ChildUser] = [ChildUser]()
    
    let ourLoveyChild = ChildUser()
    let anotherChild = ChildUser()
    
    func testRealm() {
        
        print("Add", testAdd())
        print("Update", testUpdate())
        print("Filter", testFilter())
        print("Delete", testDelete())
        print("Replace", testReplace())
        
    }
    
    func add() {
        
        realmManager.deleteAllDataForObject(ChildUser.self)
        
        let father = RealmParentUser(value: ["first_name" : "Ahmed", "last_name" : "Meguid", "age" : 32, "isHappy" : false])
        let mother = RealmParentUser(value: ["first_name" : "Ahmed", "last_name" : "Meguid", "age" : 32, "isHappy" : true])
        
        ourLoveyChild.parents += [father, mother]
        ourLoveyChild.name = "CHILD1"
        ourLoveyChild.isFine = true
        
        anotherChild.parents += [father]
        anotherChild.name = "CHILD2"
        anotherChild.toys = 0
        anotherChild.isFine = false
        
        realmManager.add([ourLoveyChild,anotherChild ])
        self.updateData()
        
    }
    
    func testAdd() -> [Bool] {
        
        add()
        
        return [children.count == 2,
                children[0].isFine == true,
                children[1].name == "CHILD2"]
        
    }
    
    func update() {
        
        realmManager.update {
            self.anotherChild.name = "CHILD3"
            self.children[0].name = "CHILD10"
        }
        self.updateData()
    }
    
    func testUpdate() -> [Bool] {
        
        self.update()
        
        return [children.count == 2,
                children[0].isFine == true,
                children[0].name == "CHILD10",
                children[1].name == "CHILD3"]
        
    }
    
    func filter() {
        
        realmManager.update {
            let fineChildren = self.children.filter{$0.isFine == false}
            _ = fineChildren.map{$0.name = "THE One I changed his name because he wasn't fine" }
        }
        self.updateData()
        
    }
    
    func testFilter() -> [Bool] {
        
        filter()
        
        return [children.count == 2,
                children[0].isFine == true,
                children[1].isFine != true,
                children[0].name == "CHILD10",
                children[1].name == "THE One I changed his name because he wasn't fine"]
        
    }
    
    func delete() {
        
        let theFineChildren = children.filter{$0.isFine == true}
        realmManager.delete(theFineChildren)
        self.updateData()
        
    }
    
    func testDelete() -> [Bool] {
        
        delete()
        
        return [children.count == 1,
                children[0].isFine == false,
                children[0].name == "THE One I changed his name because he wasn't fine"]
    }
    
    func replace() {
        
        let father = RealmParentUser(value: ["first_name" : "Ahmed", "last_name" : "Meguid", "age" : 32, "isHappy" : false])
        let mother = RealmParentUser(value: ["first_name" : "Ahmed", "last_name" : "Meguid", "age" : 32, "isHappy" : true])
        
        let ourCachedChild = ChildUser()
        ourCachedChild.parents += [father, mother]
        ourCachedChild.name = "CACHED Child"
        ourCachedChild.isFine = true
        
        cachedChildren.append(ourCachedChild)
        realmManager.replaceAllDataForObject(ChildUser.self, with: cachedChildren)
        self.updateData()
    }
    
    func testReplace() -> [Bool]  {
        
        replace()
        
        return [children.count == 1,
                children[0].isFine == true,
                children[0].name == "CACHED Child"]
        
    }
    
    func updateData() {
        
        children = realmManager.retrieveAllDataForObject(ChildUser.self).map{$0 as! ChildUser}
    }
}
