//
//  CachedFriend+CoreDataProperties.swift
//  Friends
//
//  Created by Vanüsha on 20.07.2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var users: CachedUser?

    public var wrappedID: String {
        id ?? UUID().uuidString
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
}

extension CachedFriend : Identifiable {

}
