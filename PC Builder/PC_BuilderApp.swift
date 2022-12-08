//
//  PC_BuilderApp.swift
//  PC Builder
//
//  Created by Kingsley Situ on 12/8/22.
//

import SwiftUI

@main
struct PC_BuilderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension String  {
    var isnumberordouble: Bool { return Double(self) != nil }
}
