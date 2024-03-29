//
//  DataManager.swift
//  ViaplayAssignmentF
//
//  Created by Abhishek Babladi on 2022-11-06.
//

import Foundation
import CoreData

class DataManager {
  static let shared = DataManager()

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "ViaplayAssignmentF")
    container.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
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

  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  func sec(id: String, title: String, href: String, type: String, name: String, templated: Bool) -> Section {
    let sectionContext = Section(context: persistentContainer.viewContext)
    sectionContext.name = name
    sectionContext.type = type
    sectionContext.templated = templated
    sectionContext.href = href
    sectionContext.title = title
    sectionContext.id = id
    return sectionContext
  }

    func fetchSections() throws -> [Section] {
        let request: NSFetchRequest<Section> = Section.fetchRequest()
        let fetchedSections = try persistentContainer.viewContext.fetch(request)
        return fetchedSections
    }
}

extension Section {
    convenience init(id: String,
                     title: String,
                     href: String,
                     type: String,
                     name: String,
                     templated: Bool,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = id
        self.title = title
        self.href = href
        self.type = type
        self.name = name
        self.templated = templated
    }
}
