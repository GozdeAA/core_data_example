//
//  CoreDataManager.swift
//  MyNotes
//
//  Created by Gözde Aydin on 16.02.2025.
//

import CoreData
import Foundation

// Singleton class to manage Core Data operations
class CoreDataManager {
    // Shared instance for global access (Singleton pattern)
    static let shared = CoreDataManager(modelName: "MyNotes")

    // Persistent container to manage Core Data stack
    let persistentContainer: NSPersistentContainer

    // Computed property to access the main context for interacting with Core Data
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // Private initializer to enforce singleton usage
    private init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    // Function to load persistent stores and handle potential errors
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // Fatal error in case loading fails (should ideally be handled more gracefully in production)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            // Call the completion handler if provided
            completion?()
        }
    }

    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("something went wrong while saving:( \(error.localizedDescription)")
            }
        }
    }

    func fetchNotes() -> [Note] {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        // sıralanması için
        let sortDescriptor = NSSortDescriptor(key: "l  astUpdated", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch notes: \(error.localizedDescription)")
            return []
        }

        // veya bu şekilde de yazılabilir
        // return (try? viewContext.fetch(fetchRequest)) ?? []
    }
}

extension CoreDataManager {
    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.text = ""
        note.id = UUID()
        note.lastUpdated = Calendar.current.startOfDay(for: Date())
        save()
        return note
    }
}
