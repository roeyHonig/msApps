//
//  AppDelegate.swift
//  msApps
//
//  Created by hackeru on 7 Tishri 5779.
//  Copyright © 5779 student.roey.honig. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "msApps")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    lazy var managedContext = persistentContainer.viewContext

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // saving a movie into CoreData
    func saveMovie(name title: String?, imageAdress image: String?, reportedRatings rating: Double?, releasedOn releaseYear: Int64?, classifiedAs genre: [String]? ){
        var isDuplicate = false
        // cheack if duplicate
        var myFetchedEntites: [NSManagedObject] = []
        let myPredicate = NSPredicate(format: "title" + " = %@", argumentArray: [title])
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieObject")
        fetchRequest.predicate = myPredicate
        
        do {
            let fetchedEntities = try managedContext.fetch(fetchRequest)
            myFetchedEntites = fetchedEntities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if myFetchedEntites.count != 0 {
            isDuplicate = true
        }
        
        if isDuplicate {return}
        
        let entity = NSEntityDescription.entity(forEntityName: "MovieObject", in: managedContext)!
        let newEntery = NSManagedObject(entity: entity, insertInto: managedContext)
        
        newEntery.setValue(title, forKey: "title")
        newEntery.setValue(image, forKey: "image")
        newEntery.setValue(rating, forKey: "rating")
        newEntery.setValue(releaseYear, forKey: "releaseYear")
        newEntery.setValue(genre, forKey: "genre")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        print("finished saving a movie")
        
    }
    
    // deleting a movie based on title
    // TODO: movies should have unicq id, which will be used to identify them and not by title
    func deletingThisRecipeFromMyFavoritesInCoreData(attribute att: String, whosValue val: String) {
        var myFetchedEntites: [NSManagedObject] = []
        let myPredicate = NSPredicate(format: att + " = %@", argumentArray: [val])
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieObject")
        fetchRequest.predicate = myPredicate
        
        do {
            let fetchedEntities = try managedContext.fetch(fetchRequest)
            myFetchedEntites = fetchedEntities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for entity in myFetchedEntites {
            managedContext.delete(entity)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // delete all of coreData
    func deleteAllCoreDataFor(Entity entityName: String){
        var myFetchedEntites: [NSManagedObject] = []
        //let myPredicate = NSPredicate(format: att + " = %@", argumentArray: [val])
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        //fetchRequest.predicate = myPredicate
        
        do {
            let fetchedEntities = try managedContext.fetch(fetchRequest)
            myFetchedEntites = fetchedEntities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for entity in myFetchedEntites {
            managedContext.delete(entity)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Read from CoreData
    func getMoviesFromCoreData() -> [MovieHeader] {
        var arrayToReturn: [MovieHeader] = []
        var myManagedObjectToReturn: [NSManagedObject] = []
        // fetch the coreData
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieObject")
        
        // sort by
        let descriptor1 = NSSortDescriptor(key: "releaseYear", ascending: true)
        let descriptors = [descriptor1]
        fetchRequest.sortDescriptors = descriptors
        
        // fetch according to sorting descriptions
        do {
            let favoriesTable = try managedContext.fetch(fetchRequest)
            myManagedObjectToReturn = favoriesTable
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // iterate, constrct RecipyHeader and append
        for obj in myManagedObjectToReturn {
            let title = obj.value(forKey: "title") as! String?
            let image = obj.value(forKey: "image") as! String?
            let rating = obj.value(forKey: "rating") as! Double?
            let releaseYear = obj.value(forKey: "releaseYear") as! Int64?
            let genre = obj.value(forKey: "genre") as! [String]?
       
            let tmpMovieHeader = MovieHeader(title: title, image: image, rating: rating, releaseYear: releaseYear, genre: genre)
            arrayToReturn.append(tmpMovieHeader)
            print("retrived a movie")
        }
        
        return arrayToReturn
    }

}

