//
//  CoreDataStack.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Film_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                UIViewController.topViewController()?.showAlert(alertText: "",
                                                                alertMessage: "Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                UIViewController.topViewController()?.showAlert(alertText: "",
                                                                alertMessage: "Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func save(movie: Movie) {
        let entity = MovieEntity(context: context)
        entity.id = Int64(movie.id ?? 0)
        entity.originalTitle = movie.originalTitle
        entity.title = movie.title
        entity.overview = movie.overview
        entity.posterPath = movie.posterPath
        entity.releaseDate = movie.releaseDate
        entity.voteAverage = movie.voteAverage ?? 0
        saveContext()
    }

    func delete(entity: MovieEntity) {
        context.delete(entity)
        saveContext()
    }

    func fetch() -> Movies {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do {
            let data = try context.fetch(request)
            return data.map { $0.convertToMovie() }
        } catch {
            return []
        }
    }

    @discardableResult
    func movie(with id: Int) -> MovieEntity? {
        let query = "\(Int64(id))"
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", query)
        do {
            let data = try context.fetch(request)
            return data.first
        } catch {
            return nil
        }
    }
}
