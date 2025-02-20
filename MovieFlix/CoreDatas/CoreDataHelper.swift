//
//  CoreDataHelper.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 18/2/25.
//

import Foundation
import CoreData


final class CoreDataHelper {
    static let shared = CoreDataHelper()
    private init() { }
    
    // Core Data stack
        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "MovieEntity")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

        // Core Data saving support
//        func saveContext() {
//            let context = persistentContainer.viewContext
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//                }
//            }
//        }
    
    func saveImage(image: String, title: String, release_date: String, rating: Float) {
        
        let context = persistentContainer.viewContext
        
        // Create a new entity object
        let newFavorite = FavoriteMovie(context: context)
        newFavorite.title = title
        newFavorite.image_movie = image
        newFavorite.rating = rating
        newFavorite.release_date = release_date
        
        // Save the context
        do {
            try context.save()
            print("Favorite Moview saved successfully!")
        } catch {
            print("Failed to save image: \(error.localizedDescription)")
        }
    }
    
    func fetchCoreData(onSuccess: @escaping ([FavoriteMovie]?) -> Void) {
        let context = CoreDataHelper.shared.persistentContainer.viewContext
        do {
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
            
            let items = try context.fetch(fetchRequest) as? [FavoriteMovie]
            onSuccess(items)
        } catch {
            print("error-Fetching data")
        }
    }
    
    func deleteCoreData(indexPath: Int, items: [FavoriteMovie]) {
        let context = CoreDataHelper.shared.persistentContainer.viewContext
        
        let dataToRemove = items[indexPath]
        
        context.delete(dataToRemove)
        do {
            try context.save()
        } catch {
            print("error-Deleting data")
        }
    }
}
