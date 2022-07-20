//
//  ContentView.swift
//  Friends
//
//  Created by Vanüsha on 19.07.2022.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                        Text(user.isActive ? "active" : "not active")
                            .foregroundColor(user.isActive ? .green : .red)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Friends")
        }
        .task {
            await MainActor.run {
                var newUsers: [User] = []
                for user in cachedUsers {
                    let newUser = User(id: user.wrappedID,
                                       isActive: user.isActive,
                                       name: user.wrappedName,
                                       age: user.wrappedAge,
                                       company: user.wrappedCompany,
                                       email: user.wrappedEmail,
                                       address: user.wrappedAddress,
                                       about: user.wrappedAbout,
                                       registered: user.wrappedRegistered,
                                       tags: user.wrappedTags,
                                       friends: user.wrappedFriends)
                    newUsers.append(newUser)
                }
                
                users = newUsers
            }
            
            await loadUsers()
        }
    }
    
    func loadUsers() async {
        guard users.isEmpty else { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
        else {
            print("Couldn't create URL object")
            return
        }
        
        do {
            let (encoded, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode([User].self, from: encoded)
            users = decoded
        } catch {
            print("Couldn't create users' array \(error.localizedDescription)")
        }
        
        for user in users {
            let cachedUser = CachedUser(context: managedObjectContext)
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            
            cachedUser.tags = user.tags.joined(separator: ";")
            var friends: [CachedFriend] = []
            
            for friend in user.friends {
                let newFriend = CachedFriend(context: managedObjectContext)
                newFriend.id = friend.id
                newFriend.name = friend.name
                newFriend.users = cachedUser
                friends.append(newFriend)
            }
            
            cachedUser.friends = NSSet(array: friends)
        }
        
        try? managedObjectContext.save()
    }
}
