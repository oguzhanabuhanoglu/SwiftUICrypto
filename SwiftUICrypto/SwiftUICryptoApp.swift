//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 10.05.2024.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
