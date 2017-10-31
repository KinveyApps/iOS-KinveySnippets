//
//  ViewController.swift
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-25.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userLogin() {
        User.login(username: "kinvey", password: "12345", options: nil) { (result: Result<User, Swift.Error>) in
            switch result {
            case .success(let user):
                //the log-in was successful and the user is now the active user and credentials saved
                //hide log-in view and show main app content
                print("User: \(user)")
            case .failure(let error):
                //there was an error with the update save
                let message = error.localizedDescription
                let alert = UIAlertController(
                    title: NSLocalizedString("Create account failed", comment: "Sign account failed"),
                    message: message,
                    preferredStyle: .alert
                )
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func loginFacebook() {
        //Login with Facebook
        let facebookDictionary: [String : Any] = [:]//<#...#>
        User.login(authSource: .facebook, facebookDictionary) { (result: Result<User, Swift.Error>) in
            switch result {
            case .success(let user):
                print("User: \(user)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func login() {
        let username = "test"
        let password = "test"
        
        User.login (username: username, password: password) { user, error in
            if let user = user as? CustomUser { //downcast is required to prevent compiler error on the "address" property
                if let address = user.address {
                    print(address)
                }
            } else {
                //something went wrong
            }
        }
    }
    
    func loginCustomClass() {
        let username = "test"
        let password = "test"
        
        User.login (username: username, password: password) { user, error in
            if let user = user as? CustomUser { //downcast is required to prevent compiler error on the "address" property
                user.address = "Boston MA"
                user.save()
            } else {
                //something went wrong
            }
        }
    }
    
    func signup(username: String, password: String) {
        User.signup(username: username, password: password) { user, error in
            if let user = user {
                //user is created
                print("User: \(user)")
            } else {
                //there was an error with the create
            }
        }
    }
    
    func signup() {
        User.signup { user, error in
            if let user = user {
                //success
                print("User: \(user)")
            } else {
                //error
            }
        }
    }
    
    func destroy() {
        Kinvey.sharedClient.activeUser?.destroy { (result: Result<Void, Swift.Error>) in
            switch result {
            case .success:
                print("active user deleted")
            case .failure(let error):
                print("error \(error) when deleting active user")
            }
        }
    }
    
    func checkActiveUser() {
        if let _ = Kinvey.sharedClient.activeUser {
            //show log-in views
        } else {
            //user is logged in and will be loaded on first call to Kinvey
        }
    }
    
    func logout() {
        Kinvey.sharedClient.activeUser?.logout()
    }
    
    func sendEmailConfirmationStatic(user: User) {
        if let username = user.username {
            User.sendEmailConfirmation(forUsername: username, options: nil) { (result: Result<Void, Swift.Error>) in
                switch result {
                case .success:
                    print("success")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func sendEmailConfirmationInstance(user: User) {
        user.sendEmailConfirmation() { (result: Result<Void, Swift.Error>) in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func resetPassword(user: User) {
        user.resetPassword { (result: Result<Void, Swift.Error>) in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func forgotUsername() {
        User.forgotUsername(email: "your@email.com", options: nil) { (result: Result<Void, Swift.Error>) in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func lookup() {
        if let user = Kinvey.sharedClient.activeUser {
            let userQuery = UserQuery {
                $0.email = "victor@kinvey.com"
            }
            user.lookup(userQuery) { users, error in
                if let users = users {
                    //success
                    print("Users: \(users)")
                } else {
                    //fail
                }
            }
        }
    }
    
    func usernameExists() {
        let potentialUsername = "<#The Username To Check#>"
        User.exists(username: potentialUsername) { (usernameAlreadyTaken, error) -> Void in
            if usernameAlreadyTaken {
                print("Username '\(potentialUsername)' already in use, choose another username")
            } else {
                //handle response or error
            }
        }
    }
    
    func dataStore() {
        //we use the example of a "Book" datastore
        let dataStore = DataStore<Book>.collection()
        print("\(dataStore)")
    }
    
    func save() {
        let dataStore = DataStore<Book>.collection()
        let book = Book()
        
        dataStore.save(book) { book, error in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
    }
    
    func findAll() {
        let dataStore = DataStore<Book>.collection()
        
        dataStore.find() { books, error in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func findQuery() {
        let dataStore = DataStore<Book>.collection()
        
        let query = Query(format: "title == %@", "The Hobbit")
        
        dataStore.find(query) { books, error in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func removeById() {
        let dataStore = DataStore<Book>.collection()
        
        let id = "<#entity id#>"
        dataStore.removeById(id) { count, error in
            if let count = count {
                //succeed
                print("Count: \(count)")
            } else {
                //fail
            }
        }
    }
    
    func removeByQuery() {
        let dataStore = DataStore<Book>.collection()
        
        let query = Query(format: "title == %@", "The Hobbit")
        
        dataStore.remove(query) { count, error in
            if let count = count {
                //succeed
                print("Count: \(count)")
            } else {
                //fail
            }
        }
    }
    
    func query() {
        let query = Query()
        
        print("Query: \(query)")
    }
    
    func queryFormat() {
        let query = Query(format: "location == %@", "Mike's House")
        
        print("Query: \(query)")
    }
    
    func queryModifiers() {
        let queryFor1stPage = Query {
            $0.skip = 0
            $0.limit = 20
        }
        
        let queryFor2ndPage = Query {
            $0.skip = 20
            $0.limit = 20
        }
        
        let queryFor3rdPage = Query {
            $0.skip = 40
            $0.limit = 20
        }
        
        let queryFor4thPage = Query {
            $0.skip = 60
            $0.limit = 20
        }
        
        let queryFor5thPage = Query {
            $0.skip = 80
            $0.limit = 20
        }
        
        print("Query: \(queryFor1stPage)")
        print("Query: \(queryFor2ndPage)")
        print("Query: \(queryFor3rdPage)")
        print("Query: \(queryFor4thPage)")
        print("Query: \(queryFor5thPage)")
    }
    
    func querySort() {
        let predicate = NSPredicate(format: "name == %@", "Ronald")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let query = Query(predicate: predicate, sortDescriptors: [sortDescriptor])
        
        print("Query: \(query)")
    }
    
    func queryCompoundQuery() {
        //Search for cities in Massachusetts with a population bigger than 50k.
        let query = Query(format: "state == %@ AND population >= %@", "MA", 50000)
        
        print("Query: \(query)")
    }
    
    func queryCompoundQuery2() {
        let predicateState = NSPredicate(format: "state == %@", "MA")
        let predicatePopulation = NSPredicate(format: "population >= %@", 50000)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateState, predicatePopulation])
        let query = Query(predicate: predicate)
        
        print("Query: \(query)")
    }
    
    func queryAtCount() {
        let query = Query(format: "children.@count == 2")
        
        print("\(query)")
    }
    
    func count() {
        let dataStore = DataStore<Book>.collection()
        
        dataStore.count { (count, error) in
            if let count = count {
                //succeed
                print("Count: \(count)")
            } else {
                //fail
            }
        }
    }
    
    func countQuery() {
        let dataStore = DataStore<Book>.collection()
        let myValue = ""
        let query: Query = Query(format: "myProperty == %@", myValue)
        
//      let query: Query = <#Query(format: "myProperty == %@", myValue)#>
        dataStore.count(query) { (count, error) in
            if let count = count {
                //succeed
                print("Count: \(count)")
            } else {
                //fail
            }
        }
    }
    
    func syncCount() {
        let dataStore = DataStore<Book>.collection()
        
        // Number of entities modified offline.
        let count = dataStore.syncCount()
        
        print("\(count)")
    }
    
    func timeout() {
        Kinvey.sharedClient.timeoutInterval = 120 //an NSTimeInterval value in seconds, which means 2 minutes in this case
    }
    
    func fileUpload() {
        let fileStore = FileStore.getInstance()
        
        let file = File()
        file.publicAccessible = true
        let path = "<#...#>" //String path for the file that will be upload
        //Uploads a file using a file string path
        fileStore.upload(file, path: path) { file, error in
            if let file = file {
                //success
                print("File: \(file)")
            } else {
                //fail
            }
        }
    }
    
    func fileUploadWithProgress() {
        let fileStore = FileStore.getInstance()
        let file = File()
        file.publicAccessible = true
        let path = "<#...#>" //String path for the file that will be upload
        //Uploads a file using a file string path
        let request = fileStore.upload(file, path: path) { (file, error) in
            //completion handler
        }
        
        request.progress = {
            //progress handler
            print("Upload: \($0.countOfBytesSent)/\($0.countOfBytesExpectedToSend)")
        }
    }
    
    func globalAcl() {
        let event = Event()
        
        event.acl?.globalRead.value = true // anyone can read
        event.acl?.globalWrite.value = true // anyone can modify
    }
    
    func aclReadersWriters() {
        let event = Event()
        
        if let user = Kinvey.sharedClient.activeUser {
            let userQuery = UserQuery() {
                $0.email = "<#my-friends@email.com#>"
            }
            user.lookup(userQuery) { users, error in
                if let myFriend = users?.first {
                    event.acl?.readers?.append(myFriend.userId)
                    
                    //add 'myFriend' to the writers list as well
                    event.acl?.writers?.append(myFriend.userId)
                    //... and then save the event
                }
            }
        }
    }

#if swift(>=3.0)
    
    func signup2() {
        User.signup(username: "kinvey", password: "12345", options: nil) { (result: Result<User, Swift.Error>) in
            switch result {
            case .success(let user):
                //was successful!
                let alert = UIAlertController(
                    title: NSLocalizedString("Account Creation Successful", comment: "account success note title"),
                    message: NSLocalizedString("User \(user.userId) created. Welcome!", comment: "account success message body"),
                    preferredStyle: .alert
                )
                self.present(alert, animated: true, completion: nil)
            case .failure(let error):
                //there was an error with the update save
                let message = error.localizedDescription
                let alert = UIAlertController(
                    title: NSLocalizedString("Create account failed", comment: "Create account failed"),
                    message: message,
                    preferredStyle: .alert
                )
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func login2() {
        User.login(username: "kinvey", password: "12345", options: nil) { (result: Result<User, Swift.Error>) in
            switch result {
            case .success(let user):
                //the log-in was successful and the user is now the active user and credentials saved
                
                //hide log-in view and show main app content
                print("User: \(user)")
            case .failure(let error):
                //there was an error with the update save
                let message = error.localizedDescription
                let alert = UIAlertController(
                    title: NSLocalizedString("Create account failed", comment: "Sign account failed"),
                    message: message,
                    preferredStyle: .alert
                )
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func loginWithFacebook() {
        let facebookDictionary: [String : Any] = [:]
        User.login(authSource: .facebook, facebookDictionary) { user, error in
            if let user = user {
                //success
                print("User: \(user)")
            } else {
                //fail
            }
        }
    }
    
    func findById() {
        let dataStore = DataStore<Book>.collection()
    
        let id = "<#entity id#>"
        dataStore.find(byId: id) { book, error in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
    }
    
    func sync() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.sync)
        
        // Pull data from your backend and save it locally on the device.
        dataStore.pull() { (books, error) -> Void in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
        
        // Find data locally on the device.
        dataStore.find() { (books, error) -> Void in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
        
        // Save an entity locally on the device. This will add the item to the
        // sync table to be pushed to your backend at a later time.
        
        let book = Book()
        dataStore.save(book) { (book, error) -> Void in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
        
        // Sync local data with the backend
        // This will push data that is saved locally on the device to your backend;
        // and then pull any new data on the backend and save it locally.
        dataStore.sync() { (count, books, error) -> Void in
            if let books = books, let count = count {
                //succeed
                print("\(count) Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func pull() {
        let dataStore = DataStore<Book>.collection(.sync)
        
        //In this example, we pull all the data in the collection from the backend
        //to the Sync Store
        dataStore.pull { books, error in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func push() {
        let dataStore = DataStore<Book>.collection(.sync)
    
        //In this example, we push all local data in this datastore to the backend
        //No data is retrieved from the backend.
        dataStore.push { count, error in
            if let count = count {
                //succeed
                print("Count: \(count)")
            } else {
                //fail
            }
        }
    }
    
    func sync2() {
        let dataStore = DataStore<Book>.collection(.sync)

        //In this sample, we push all local data for this datastore to the backend, and then 
        //pull the entire collection from the backend to the local storage
        dataStore.sync() { count, books, error in
            if let books = books, let count = count {
                //succeed
                print("\(count) Books: \(books)")
            } else {
                //fail
            }
        }

        //In this example, we restrict the data that is pulled from the backend to the local storage,
        //by specifying a query in the sync API
        let query = Query()

        dataStore.sync(query) { count, books, error in
            if let books = books, let count = count {
                //succeed
                print("\(count) Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func cache() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.cache)

        // The completion handler block will be called twice,
        // #1 call: will return the cached data stored locally
        // #2 call: will return the data retrieved from the network
        dataStore.find() { books, error in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }

        // Save an entity. The entity will be saved to the device and your backend. 
        // If you do not have a network connection, the entity will be stored locally. You will need to push it to the server when network reconnects, using dataStore.push().
        let book = Book()
        dataStore.save(book) { book, error in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
    }
    
    func network() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.network)

        // Retrieve data from your backend
        dataStore.find() { (books, error) -> Void in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }

        // Save an entity to your backend.
        let book = Book()
        dataStore.save(book) { (book, error) -> Void in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
    }
    
    func readPolicy() {
        //create a Sync store
        let dataStore = DataStore<Book>.collection(.sync)
            
        //force the datastore to request data from the backend
        dataStore.find(readPolicy: .forceNetwork) { books, error in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func ttl() {
        // Set the TTL for the Sync store to 1 hour
        let dataStore = DataStore<Book>.collection(.sync)
        dataStore.ttl = TTL(1, .hour)
    }
    
    func deltaSetCache() {
        //create a Sync data store with delta set caching enabled
        let dataStore = DataStore<Book>.collection(.sync, deltaSet: true)
        
        print("\(dataStore)")
    }
    
    func fileDownloadData() {
        let fileStore = FileStore.getInstance()
        
        let file = File()
        file.fileId = "<#...#>" //File ID returned after you upload the file
        fileStore.download(file) { (file, data: Data?, error) in
            if let file = file, let data = data {
                //success
                print("File: \(file)")
                print("Data: \(data.count)")
            } else {
                //fail
            }
        }
    }
    
    func fileDownloadURL() {
        let fileStore = FileStore.getInstance()
        let file = File()
        file.fileId = "<#...#>" //File ID returned after you upload the file
        fileStore.download(file) { (file, url: URL?, error) in
            if let file = file, let url = url {
                //success
                print("File: \(file)")
                print("URL: \(url)")
            } else {
                //fail
            }
        }
    }
    
    func fileDownloadNoCache() {
        let fileStore = FileStore.getInstance()
        let file = File()
        
        fileStore.download(file, storeType: .network) { (file, url: URL?, error) in
            if let file = file, let url = url {
                //success
                print("File: \(file)")
                print("URL: \(url)")
            } else {
                //fail
            }
        }
    }
    
    func fileDownloadWithProgress() {
        let fileStore = FileStore.getInstance()
        let file: File = File()
        
        let request = fileStore.download(file) { (file, url: URL?, error) in
            //completion handler
        }
        
        request.progress = {
            //progress handler
            print("Download: \($0.countOfBytesReceived)/\($0.countOfBytesExpectedToReceive)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkActiveUser()
    }
    
#else
    
    func signup2() {
        User.signup(username: "kinvey", password: "12345") { user, error in
            if let _ = user {
                //was successful!
                let alert = UIAlertController(
                    title: NSLocalizedString("Account Creation Successful", comment: "account success note title"),
                    message: NSLocalizedString("User created. Welcome!", comment: "account success message body"),
                    preferredStyle: .Alert
                )
                self.presentViewController(alert, animated: true, completion: nil)
            } else if let error = error as? NSError {
                //there was an error with the update save
                let message = error.localizedDescription
                let alert = UIAlertController(
                    title: NSLocalizedString("Create account failed", comment: "Create account failed"),
                    message: message,
                    preferredStyle: .Alert
                )
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func login2() {
        User.login(username: "kinvey", password: "12345") { user, error in
            if let user = user {
                //the log-in was successful and the user is now the active user and credentials saved
                
                //hide log-in view and show main app content
                print("User: \(user)")
            } else if let error = error as? NSError {
                //there was an error with the update save
                let message = error.localizedDescription
                let alert = UIAlertController(
                    title: NSLocalizedString("Create account failed", comment: "Sign account failed"),
                    message: message,
                    preferredStyle: .Alert
                )
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func loginWithFacebook() {
        let facebookDictionary: [String : AnyObject] = [:]
        User.login(authSource: .Facebook, facebookDictionary) { user, error in
            if let user = user {
                //success
                print("User: \(user)")
            } else {
                //fail
            }
        }
    }
    
    func findById() {
        let dataStore = DataStore<Book>.collection()
        
        let id = "<#entity id#>"
        dataStore.findById(id) { book, error in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
    }
    
    func sync() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.Sync)
        
        // Pull data from your backend and save it locally on the device.
        dataStore.pull() { (books, error) -> Void in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
        
        // Find data locally on the device.
        dataStore.find() { (books, error) -> Void in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
        
        // Save an entity locally on the device. This will add the item to the
        // sync table to be pushed to your backend at a later time.
        
        let book = Book()
        dataStore.save(book) { (book, error) -> Void in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
        
        // Sync local data with the backend
        // This will push data that is saved locally on the device to your backend;
        // and then pull any new data on the backend and save it locally.
        dataStore.sync() { (count, books, error) -> Void in
            if let books = books, let count = count {
                //succeed
                print("\(count) Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func pull() {
        let dataStore = DataStore<Book>.collection(.Sync)
        
        //In this example, we pull all the data in the collection from the backend
        //to the Sync Store
        dataStore.pull { books, error in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func push() {
        let dataStore = DataStore<Book>.collection(.Sync)
        
        //In this example, we push all local data in this datastore to the backend
        //No data is retrieved from the backend.
        dataStore.push { count, error in
            if let count = count {
                //succeed
                print("Count: \(count)")
            } else {
                //fail
            }
        }
    }
    
    func sync2() {
        let dataStore = DataStore<Book>.collection(.Sync)
        
        //In this sample, we push all local data for this datastore to the backend, and then
        //pull the entire collection from the backend to the local storage
        dataStore.sync() { count, books, error in
            if let books = books, let count = count {
                //succeed
                print("\(count) Books: \(books)")
            } else {
                //fail
            }
        }
        
        //In this example, we restrict the data that is pulled from the backend to the local storage,
        //by specifying a query in the sync API
        let query = Query()
        
        dataStore.sync(query) { count, books, error in
            if let books = books, let count = count {
                //succeed
                print("\(count) Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func cache() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.Cache)
        
        // The completion handler block will be called twice,
        // #1 call: will return the cached data stored locally
        // #2 call: will return the data retrieved from the network
        dataStore.find() { books, error in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
        
        // Save an entity. The entity will be saved to the device and your backend.
        // If you do not have a network connection, the entity will be stored locally. You will need to push it to the server when network reconnects, using dataStore.push().
        let book = Book()
        dataStore.save(book) { book, error in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
    }
    
    func network() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.Network)
        
        // Retrieve data from your backend
        dataStore.find() { (books, error) -> Void in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
        
        // Save an entity to your backend.
        let book = Book()
        dataStore.save(book) { (book, error) -> Void in
            if let book = book {
                //succeed
                print("Book: \(book)")
            } else {
                //fail
            }
        }
    }
    
    func readPolicy() {
        //create a Sync store
        let dataStore = DataStore<Book>.collection(.Sync)
            
        //force the datastore to request data from the backend
        dataStore.find(readPolicy: .ForceNetwork) { books, error in
            if let books = books {
                //succeed
                print("Books: \(books)")
            } else {
                //fail
            }
        }
    }
    
    func ttl() {
        // Set the TTL for the Sync store to 1 hour
        let dataStore = DataStore<Book>.collection(.Sync)
        dataStore.ttl = TTL(1, .Hour)
    }
    
    func deltaSetCache() {
        //create a Sync data store with delta set caching enabled
        let dataStore = DataStore<Book>.collection(.Sync, deltaSet: true)
    
        print("\(dataStore)")
    }
    
    func fileDownloadData() {
        let fileStore = FileStore.getInstance()
        
        let file = File()
        file.fileId = "<#...#>" //File ID returned after you upload the file
        fileStore.download(file) { (file, data: NSData?, error) in
            if let file = file, let data = data {
                //success
                print("File: \(file)")
                print("Data: \(data.length)")
            } else {
                //fail
            }
        }
    }
    
    func fileDownloadURL() {
        let fileStore = FileStore.getInstance()
        let file = File()
        file.fileId = "<#...#>" //File ID returned after you upload the file
        fileStore.download(file) { (file, url: NSURL?, error) in
            if let file = file, let url = url {
                //success
                print("File: \(file)")
                print("URL: \(url)")
            } else {
                //fail
            }
        }
    }
    
    func fileDownloadNoCache() {
        let fileStore = FileStore.getInstance()
        let file = File()
    
        fileStore.download(file, storeType: .Network) { (file, url: NSURL?, error) in
            if let file = file, let url = url {
                //success
                print("File: \(file)")
                print("URL: \(url)")
            } else {
                //fail
            }
        }
    }
    
    func fileDownloadWithProgress() {
        let fileStore = FileStore.getInstance()
        let file: File = File()
    
        let request = fileStore.download(file) { (file, url: NSURL?, error) in
            //completion handler
        }

        request.progress = {
            //progress handler
            print("Download: \($0.countOfBytesReceived)/\($0.countOfBytesExpectedToReceive)")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        checkActiveUser()
    }
    
#endif

}

