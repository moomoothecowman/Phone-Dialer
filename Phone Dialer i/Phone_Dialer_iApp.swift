//
//  Phone_Dialer_iApp.swift
//  Phone Dialer i
//
//  Created by Tyler Welch on 1/11/23.
//

import SwiftUI

@main
struct Phone_Dialer_iApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
