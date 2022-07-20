//
//  CachedUser+CoreDataProperties.swift
//  Friends
//
//  Created by Vanüsha on 20.07.2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    public var wrappedID: String {
        id ?? UUID().uuidString
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedAge: Int {
        Int(age)
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    
    public var wrappedAbout: String {
        about ?? "Unknown About"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    public var wrappedTags: [String] {
        tags?.components(separatedBy: ";") ?? []
    }
    
    public var wrappedFriends: [Friend] {
        guard let set = friends as? Set<CachedFriend>
        else { return [] }
        
        var friends: [Friend] = []
        
        for friend in set {
            let newFriend = Friend(id: friend.wrappedID,
                                   name: friend.wrappedName)
            friends.append(newFriend)
        }
        
        return friends
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
