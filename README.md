# Realm Manager
A manager for realm database


## Usage

### Store Items to Realm

```swift
let oliver = User()
oliver.firstName = "Oliver"
oliver.lastName = "Queen"
oliver.nickname = "Arrow"

let felicity = User()
felicity.firstName = "Felicity"
felicity.lastName = "Smoak"
felicity.nickname = "Felicity"

realmManager.add([oliver,felicity])
```
        
### Update Stored Items

```swift
realmManager.update {
            oliver.nickname = "Green Arrow"
            felicity.nickname = "Overwatch"
        }
```
      
### Retrieve All Stored Items for Object

```swift
let teamArrow = realmManager.retrieveAllDataForObject(User.self).map{$0 as! User}
```


### Delete Item

```swift
realmManager.delete(oliver)

realmManager.delete(teamArrow.filter{$0.lastName == "Queen"})
```

### Replace All Stored Items for Object

```swift

var teamFlash : [User] = [User]()

let barry = User()
barry.firstName = "Barry"
barry.lastName = "Allen"
barry.nickname = "Flash"
teamFlash.append(barry)

let iris = User()
iris.firstName = "Iris"
iris.lastName = "West"
iris.nickname = "Iris"
teamFlash.append(iris)

realmManager.replaceAllDataForObject(User.self, with: teamFlash)
```     
     
             

