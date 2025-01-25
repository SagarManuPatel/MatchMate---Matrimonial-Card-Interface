//
//  CoreDataManager.swift
//  MatchMate
//
//  Created by Sagar Patel on 25/01/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MatchMate")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed to load: \(error)")
            }
        }
    }
    
    // MARK: - Save Context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save Core Data context: \(error)")
            }
        }
    }
    
    // MARK: - Fetch Profiles
    func fetchProfiles() -> [UserEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch profiles: \(error)")
            return []
        }
    }
    
    // MARK: - Add New User
    func addUser(id: String, firstName: String, lastName: String, imageURL: String, status: String, city: String, state: String , country: String) {
        let context = persistentContainer.viewContext
        let user = UserEntity(context: context)
        user.userId = id
        user.firstName = firstName
        user.lastName = lastName
        user.imageURL = imageURL
        user.status = status
        user.city = city
        user.state = state
        user.country = country
        saveContext()
    }
    
    // MARK: - Update User Status
    func updateUserStatus(id: String, status: String) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", id as CVarArg)
        
        do {
            if let user = try context.fetch(fetchRequest).first {
                user.status = status
                saveContext()
            }
        } catch {
            print("Failed to update user status: \(error)")
        }
    }
}
