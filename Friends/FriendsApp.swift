//
//  FriendsApp.swift
//  Friends
//
//  Created by Vanüsha on 19.07.2022.
//

import SwiftUI

@main
struct FriendsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
