//
//  UserDetailView.swift
//  Friends
//
//  Created by Vanüsha on 19.07.2022.
//

import SwiftUI

struct UserDetailView: View {
    @State var user: User
    
    var body: some View {
        Form {
            Section("Info") {
                VStack(alignment: .leading) {
                    Text("Age")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("\(user.age) y.o.")
                    
                    Text(user.isActive ? "active" : "not active")
                        .foregroundColor(user.isActive ? .green : .red)
                        .font(.caption)
                }
                
                VStack(alignment: .leading) {
                    Text("Registered")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(user.registered.formatted(date: .complete, time: .omitted))
                }
                
                VStack(alignment: .leading) {
                    Text("Tags")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(user.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(.blue)
                                    .clipShape(Capsule())
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            
            Section("Contacts") {
                VStack(alignment: .leading) {
                    Text("Company")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(user.company)
                }
                
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(user.email)
                }
                
                VStack(alignment: .leading) {
                    Text("Address")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(user.address)
                }
                
                VStack(alignment: .leading) {
                    Text("About")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(user.about)
                }
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
