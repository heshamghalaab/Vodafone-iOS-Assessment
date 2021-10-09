[![Swift 5](https://img.shields.io/badge/Swift-5-green.svg?style=flat)](https://swift.org/)

Xcode Version 13.0 (13A233) 

# IoT Digital Services Engineering Technical Assessment

### Dev Setup
```
- Just Run! 😎
```

## Dev Notes ##

### Design Pattern
- This project uses the **Model View View Model pattern**, as it has the below key values:
* **Better Separation of Concerns** The view model translates the data of the model layer into something the view layer can use. The controller is no longer responsible for this task.
* **Improved Testability** View controllers are notoriously hard to test because of their relation to the view layer. By migrating data manipulation to the view model, testing becomes much easier.
* **Transparent Communication** The responsibilities of the view controller are reduced to controlling the interaction between the view layer and the model layer, glueing both layers together. The view model provides a transparant interface to the view controller, which it uses to populate the view layer and interact with the model layer. This results in a transparant communication between the four layers of the application.

### Unit Testing
- The project uses XCTest for unit test.

## Task Overview:
- Develop iOS mobile app that display list of photos queried from a public API, there should be an ad placeholder after every 5 photos, and user can open a photo by clicking on it to be fully presented. 

## Tasks:
- [x] Creating App structure.
- [x] Building Network Layer and adding photos Provider.
- [x] Handling Photos Screen UI and fetching the data to it.
- [x] Handling Ad Place Holder Logic.
- [ ] Handling showing Photo in full screen.
- [ ] Handling Cashing and Offline Mode.
- [ ] Writing unit tests.
