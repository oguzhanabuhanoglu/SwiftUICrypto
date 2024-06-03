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
    @State var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView{
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)
                
                if showLaunchView {
                    LaunchScreen(showLaunchView: $showLaunchView)
                        .transition(.move(edge: .leading))
                }
                
            }
            
            
        }
    }
}
