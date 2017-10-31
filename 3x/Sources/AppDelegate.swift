//
//  AppDelegate.swift
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-25.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func appBadge() {
        Kinvey.sharedClient.push.badgeNumber = 100 //sets to 100
        
        Kinvey.sharedClient.push.resetBadgeNumber() //sets badgeNumber to 0
    }
    
    func encrypted() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            encrypted: true
        )
    }
    
    func micApiVersion() {
        Client.sharedClient.micApiVersion = .v2 //v1 is the default value
    }
    
#if swift(>=4.0)
    
    func migrationSocialLogin() {
        //Login with Facebook
        let facebookDictionary: [String : Any] = [:]//<#...#>
        User.login(authSource: .facebook, facebookDictionary) {
            switch $0 {
            case .success(let user):
                print("User: \(user)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func migrationPresentMICViewController() {
        let redirect = URL(string: "<#myRedirectUri://#>")! //this uri must match one of the uris configured in your app's "Auth Source"
        User.presentMICViewController(redirectURI: redirect) {
            switch $0 {
            case .success(let user):
                //logged in successfully
                print("User: \(user)")
            case .failure(let error):
                //something went wrong
                print("Error: \(error)")
            }
        }
    }
    
    func migrationUsingDedicatedInstance() {
        //Here we set the apiHostName to a sample url.
        //Replace the sample url with the url of your dedicated Kinvey backend.
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            apiHostName: URL(string: "<#https://my-url.kinvey.com/#>")!
        ) {
            switch $0 {
            case .success(let user):
                if let user = user {
                    print("User: \(user)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func security() {
        /// Event.swift - an entity in the 'Events' collection
        class Event : Entity {
            
            var name: String?
            var date: Date?
            var location: String?
            
            override class func collectionName() -> String {
                return "Event"
            }
            
            override func propertyMapping(_ map: Map) {
                super.propertyMapping(map)
                
                name <- ("name", map["name"])
                date <- ("date", map["date"], KinveyDateTransform())
                location <- ("location", map["location"])
            }
        }
    }
    
    func downloadProgress() {
        let fileStore = FileStore<File>()
        let file = File()
        
        let request = fileStore.download(file, options: nil) { (result: Result<(File, URL), Swift.Error>) in
            //completion handler
        }
        
        request.progress = {
            //progress handler
            print("Download: \($0.countOfBytesReceived)/\($0.countOfBytesExpectedToReceive)")
        }
    }
    
    func downloadFileNoCache() {
        let fileStore = FileStore<File>()
        let file = File()
        
        fileStore.download(file, storeType: .network, options: nil) { (result: Result<(File, URL), Swift.Error>) in
            switch result {
            case .success(let file, let url):
                print("File: \(file)")
                print("URL: \(url)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func downloadFileURL() {
        let fileStore = FileStore<File>()
        let file = File()
        file.fileId = "<#...#>" //File ID returned after you upload the file
        fileStore.download(file, options: nil) { (result: Result<(File, URL), Swift.Error>) in
            switch result {
            case .success(let file, let url):
                print("File: \(file)")
                print("URL: \(url)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func downloadFileData() {
        let fileStore = FileStore<File>()
        
        let file = File()
        file.fileId = "<#...#>" //File ID returned after you upload the file
        fileStore.download(file, options: nil) { (result: Result<(File, Data), Swift.Error>) in
            switch result {
            case .success(let file, let data):
                print("File: \(file)")
                print("Data: \(data.count)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func encryption() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            encryptionKey: "<#Your encryption key#>".data(using: .utf8)
        ) {
            switch $0 {
            case .success(let user):
                if let user = user {
                    print("User: \(user)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func initiateTheLoginFlow() {
        User.login(
            redirectURI: URL(string: "<#myRedirectURI://#>")!,
            username: "<#myUsername#>",
            password: "<#myPassword#>"
        ) {
            switch $0 {
            case .success(let user):
                //logged in successfully
                print("User: \(user)")
            case .failure(let error):
                //something went wrong
                print("Error: \(error)")
            }
        }
    }
    
    func presentMICViewController() {
        let redirect = URL(string: "<#myRedirectUri://#>")! //this uri must match one of the uris configured in your app's "Auth Source"
        User.presentMICViewController(redirectURI: redirect) {
            switch $0 {
            case .success(let user):
                //logged in successfully
                print("User: \(user)")
            case .failure(let error):
                //something went wrong
                print("Error: \(error)")
            }
        }
    }
    
    func oauthClientId() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            authHostName: URL(string: "<#https://my-subdomain.kinvey.com#>")!
        ) {
            switch $0 {
            case .success(let user):
                if let user = user {
                    print("User: \(user)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func appSetUp() {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
            //Your App Setup...
            
            Kinvey.sharedClient.initialize(appKey: "<#Your app key#>", appSecret: "<#Your app secret#>") { (result: Result<User?, Swift.Error>) in
                switch result {
                case .success(let user):
                    if let user = user {
                        print("User: \(user)")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            
            let completionHandler = { (result: Result<Bool, Swift.Error>) in
                switch result {
                case .success(let succeed):
                    print("succeed: \(succeed)")
                case .failure(let error):
                    print("error: \(error)")
                }
            }
            if #available(iOS 10.0, *) {
                Kinvey.sharedClient.push.registerForNotifications(options: nil, completionHandler: completionHandler)
            } else {
                Kinvey.sharedClient.push.registerForPush(completionHandler: completionHandler)
            }
            
            return true
        }
    }
    
    func userClass() {
        class CustomUser: User {
            
            var address: String?
            
            override func mapping(map: Map) {
                super.mapping(map: map)
                
                address <- ("address", map["address"])
            }
        }
    }
    
    func initializeKinveyClient() {
        //Set the apiHostName to a sample url.
        //Replace the sample url with the url of your dedicated Kinvey backend.
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            apiHostName: URL(string: "<#https://my-url.kinvey.com/#>")!
        ) {
            switch $0 {
            case .success(let user):
                if let user = user {
                    print("User: \(user)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func deltaSetCaching() {
        //create a Sync data store with delta set caching enabled
        let dataStore = DataStore<Book>.collection(.sync, deltaSet: true)
        
        print(dataStore)
    }
    
    func dataReadsReadPolicy() {
        //create a Sync store
        let dataStore = DataStore<Book>.collection(.sync)
        
        //force the datastore to request data from the backend
        dataStore.find { (result: Result<AnyRandomAccessCollection<Book>, Swift.Error>) in
            switch result {
            case .success(let books):
                print("Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func networkCache() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.network)
        
        // Retrieve data from your backend
        dataStore.find() { (result: Result<AnyRandomAccessCollection<Book>, Swift.Error>) in
            switch result {
            case .success(let books):
                print("Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        // Save an entity to your backend.
        let book = Book()
        dataStore.save(book, options: nil) { (result: Result<Book, Swift.Error>) in
            switch result {
            case .success(let book):
                print("Book: \(book)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func cacheStore() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.cache)
        
        // The completion handler block will be called twice,
        // #1 call: will return the cached data stored locally
        // #2 call: will return the data retrieved from the network
        dataStore.find() { (result: Result<AnyRandomAccessCollection<Book>, Swift.Error>) in
            switch result {
            case .success(let books):
                print("Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        // Save an entity. The entity will be saved to the device and your backend.
        // If you do not have a network connection, the entity will be stored locally. You will need to push it to the server when network reconnects, using dataStore.push().
        let book = Book()
        dataStore.save(book, options: nil) { (result: Result<Book, Swift.Error>) in
            switch result {
            case .success(let book):
                print("Book: \(book)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func syncOperation() {
        let dataStore = DataStore<Book>.collection(.sync)
        
        //In this sample, we push all local data for this datastore to the backend, and then
        //pull the entire collection from the backend to the local storage
        dataStore.sync() { (result: Result<(UInt, AnyRandomAccessCollection<Book>), [Swift.Error]>) in
            switch result {
            case .success(let count, let books):
                print("\(count) Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        //In this example, we restrict the data that is pulled from the backend to the local storage,
        //by specifying a query in the sync API
        let query = Query()
        
        dataStore.sync(query) { (result: Result<(UInt, AnyRandomAccessCollection<Book>), [Swift.Error]>) in
            switch result {
            case .success(let count, let books):
                print("\(count) Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func pushOperation() {
        let dataStore = DataStore<Book>.collection(.sync)
        
        //In this example, we push all local data in this datastore to the backend
        //No data is retrieved from the backend.
        dataStore.push(options: nil) { (result: Result<UInt, [Swift.Error]>) in
            switch result {
            case .success(let count):
                print("Count: \(count)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func pullOperation() {
        let dataStore = DataStore<Book>.collection(.sync)
        
        //In this example, we pull all the data in the collection from the backend
        //to the Sync Store
        dataStore.pull { (result: Result<AnyRandomAccessCollection<Book>, Swift.Error>) in
            switch result {
            case .success(let books):
                print("Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func sync() {
        // Get an instance
        let dataStore = DataStore<Book>.collection(.sync)
        
        // Pull data from your backend and save it locally on the device.
        dataStore.pull() { (result: Result<AnyRandomAccessCollection<Book>, Swift.Error>) in
            switch result {
            case .success(let books):
                print("Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        // Find data locally on the device.
        dataStore.find() { (result: Result<AnyRandomAccessCollection<Book>, Swift.Error>) in
            switch result {
            case .success(let books):
                print("Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        // Save an entity locally on the device. This will add the item to the
        // sync table to be pushed to your backend at a later time.
        
        let book = Book()
        dataStore.save(book, options: nil) { (result: Result<Book, Swift.Error>) in
            switch result {
            case .success(let book):
                print("Book: \(book)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        // Sync local data with the backend
        // This will push data that is saved locally on the device to your backend;
        // and then pull any new data on the backend and save it locally.
        dataStore.sync() { (result: Result<(UInt, AnyRandomAccessCollection<Book>), [Swift.Error]>) in
            switch result {
            case .success(let count, let books):
                print("\(count) Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func count() {
        let query = Query(format: "children.@count == 2")
        
        print(query)
    }
    
    func count2() {
        let dataStore = DataStore<Book>.collection()
        
        dataStore.count(options: nil) { (result: Result<Int, Swift.Error>) in
            switch result {
            case .success(let count):
                print("Count: \(count)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func count3() {
        let dataStore = DataStore<Book>.collection()
        let myValue = 1
        
        let query: Query = Query(format: "myProperty == %@", myValue) //<#Query(format: "myProperty == %@", myValue)#>
        dataStore.count(query, options: nil) { (result: Result<Int, Swift.Error>) in
            switch result {
            case .success(let count):
                print("Count: \(count)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func compoundQueries() {
        //Search for cities in Massachusetts with a population bigger than 50k.
        let query = Query(format: "state == %@ AND population >= %@", "MA", 50000)
        
        print(query)
    }
    
    func compoundQueries2() {
        let predicateState = NSPredicate(format: "state == %@", "MA")
        let predicatePopulation = NSPredicate(format: "population >= %@", 50000)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateState, predicatePopulation])
        let query = Query(predicate: predicate)
        
        print(query)
    }
    
    func sort() {
        let predicate = NSPredicate(format: "name == %@", "Ronald")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let query = Query(predicate: predicate, sortDescriptors: [sortDescriptor])
        
        print(query)
    }
    
    func modifiers() {
        let pageOne = Query {
            $0.skip = 0
            $0.limit = 20
        }
        
        let pageTwo = Query {
            $0.skip = 20
            $0.limit = 20
        }
        
        print(pageOne)
        print(pageTwo)
    }
    
    func querying() {
        let query = Query()
        
        print(query)
    }
    
    func querying2() {
        let query = Query(format: "location == %@", "Mike's House")
        
        print(query)
    }
    
    func deletingMultipleEntitiesAtOnce() {
        let dataStore = DataStore<Book>.collection()
        
        let query = Query(format: "title == %@", "The Hobbit")
        
        dataStore.remove(query, options: nil) { (result: Result<Int, Swift.Error>) in
            switch result {
            case .success(let count):
                print("Count: \(count)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func deleting() {
        let dataStore = DataStore<Book>.collection()
        
        let id = "<#entity id#>"
        dataStore.remove(byId: id, options: nil) { (result: Result<Int, Swift.Error>) in
            switch result {
            case .success(let count):
                print("Count: \(count)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func saving() {
        let dataStore = DataStore<Book>.collection()
        let book = Book()
        
        dataStore.save(book, options: nil) { (result: Result<Book, Swift.Error>) in
            switch result {
            case .success(let book):
                print("Book: \(book)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func fetchingByQuery() {
        let dataStore = DataStore<Book>.collection()
        
        dataStore.find() { (result: Result<AnyRandomAccessCollection<Book>, Swift.Error>) in
            switch result {
            case .success(let books):
                print("Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func fetchingByQuery2() {
        let dataStore = DataStore<Book>.collection()
        
        let query = Query(format: "title == %@", "The Hobbit")
        dataStore.find(query) { (result: Result<AnyRandomAccessCollection<Book>, Swift.Error>) in
            switch result {
            case .success(let books):
                print("Books: \(books)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func fetchingById() {
        let dataStore = DataStore<Book>.collection()
        
        let id = "<#entity id#>"
        dataStore.find(id, options: nil) { (result: Result<Book, Swift.Error>) in
            switch result {
            case .success(let book):
                print("Book: \(book)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
#elseif swift(>=3.0)
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
//        Kinvey.sharedClient.initialize(
//            appKey: "kid_WyWKm0pPM-",
//            appSecret: "1f94baeb156b4acf9674f979df680ca2"
//        )
//        
//        Kinvey.sharedClient.initialize(
//            appKey: "kid_WyWKm0pPM-",
//            appSecret: "1f94baeb156b4acf9674f979df680ca2",
//            apiHostName: URL(string: "https://baas.kinvey.com/")!
//        )
//    
//        Kinvey.sharedClient.userType = CustomUser.self
//        
//        return true
//    }
    
    func _application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        //Your App Setup...
        
        Kinvey.sharedClient.initialize(appKey: "<#Your app key#>", appSecret: "<#Your app secret#>")
        
        let completionHandler = { (result: Result<Bool, Swift.Error>) in
            switch result {
            case .success(let succeed):
                print("succeed: \(succeed)")
            case .failure(let error):
                print("error: \(error)")
            }
        }
        if #available(iOS 10.0, *) {
            Kinvey.sharedClient.push.registerForNotifications(options: nil, completionHandler: completionHandler)
        } else {
            Kinvey.sharedClient.push.registerForPush(completionHandler: completionHandler)
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        //Your App Setup...
        
        Kinvey.sharedClient.initialize(appKey: "<#Your app key#>", appSecret: "<#Your app secret#>")
        
        if #available(iOS 10.0, *) {
            Kinvey.sharedClient.push.registerForNotifications(options: nil)
        } else {
            Kinvey.sharedClient.push.registerForPush() { (result: Result<Bool, Swift.Error>) in
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // Push Notification handling code should be performed here
    }
    
    func encryption() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            encryptionKey: "<#Your encryption key#>".data(using: .utf8)
        )
    }
    
    func mic1() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            authHostName: URL(string: "<#https://my-subdomain.kinvey.com#>")!
        )
    }
    
    func presentMICViewController() {
        let redirect = URL(string: "<#myRedirectUri://#>")! //this uri must match one of the uris configured in your app's "Auth Source"
        User.presentMICViewController(redirectURI: redirect) { user, error in
            if (user != nil) {
                //logged in successfully
            } else if (error != nil) {
                //something went wrong if the error object is not nil
            } else {
                //should never happen!
            }
        }
    }
    
    func loginAuthorization() {
        User.login(
            redirectURI: URL(string: "<#myRedirectURI://#>")!,
            username: "<#myUsername#>",
            password: "<#myPassword#>"
        ) { user, error in
            if let user = user {
                //logged in successfully
                print("User: \(user)")
            } else if let error = error {
                //something went wrong if the error object is not nil
                print("Error: \(error)")
            } else {
                //should never happen!
            }
        }
    }
    
#else
    
//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
//        Kinvey.sharedClient.initialize(
//            appKey: "<#Your app key#>",
//            appSecret: "<#Your app key#>"
//        )
//    
//        Kinvey.sharedClient.initialize(
//            appKey: "<#Your app key#>",
//            appSecret: "<#Your app key#>",
//            apiHostName: NSURL(string: "<#https://my-subdomain.kinvey.com/#>")!
//        )
//        
//        Kinvey.sharedClient.userType = CustomUser.self
//    
//        return true
//    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        //Your App Setup...
        
        Kinvey.sharedClient.initialize(appKey: "<#Your app key#>", appSecret: "<#Your app key#>")
        
        Kinvey.sharedClient.push.registerForPush()
        
        return true
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        // Push Notification handling code should be performed here
    }
    
    func encryption() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            encryptionKey: "<#Your encryption key#>".dataUsingEncoding(NSUTF8StringEncoding)
        )
    }
    
    func mic1() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            authHostName: NSURL(string: "<#https://my-subdomain.kinvey.com#>")!
        )
    }
    
    func presentMICViewController() {
        let redirect = NSURL(string: "<#myRedirectUri://#>")! //this uri must match one of the uris configured in your app's "Auth Source"
        User.presentMICViewController(redirectURI: redirect) { user, error in
            if (user != nil) {
                //logged in successfully
            } else if (error != nil) {
                //something went wrong if the error object is not nil
            } else {
                //should never happen!
            }
        }
    }
    
    func loginAuthorization() {
        User.loginWithAuthorization(
            redirectURI: NSURL(string: "<#myRedirectURI://#>")!,
            username: "<#myUsername#>",
            password: "<#myPassword#>"
        ) { user, error in
            if let user = user {
                //logged in successfully
                print("User: \(user)")
            } else if let error = error {
                //something went wrong if the error object is not nil
                print("Error: \(error)")
            } else {
                //should never happen!
            }
        }
    }
    
#endif
    
}
