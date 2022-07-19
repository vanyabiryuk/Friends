//
//  ContentView.swift
//  Friends
//
//  Created by Vanüsha on 19.07.2022.
//

import SwiftUI

struct ContentView: View {
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
            await loadUsers()
        }
    }
    
    func loadUsers() async {
        guard users.isEmpty else {
            print("Users are already loaded")
            return
        }
        
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
    }
}
