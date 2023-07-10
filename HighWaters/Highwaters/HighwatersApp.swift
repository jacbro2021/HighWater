//
//  HighwatersApp.swift
//  Highwaters
//
//  Created by jacob brown on 7/9/23.
//

import SwiftUI

@main
struct HighwatersApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(_vm: ContentViewModel())
        }
    }
}
