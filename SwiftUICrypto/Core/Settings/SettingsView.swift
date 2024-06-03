//
//  SettingsView.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 3.06.2024.
//

import SwiftUI

struct SettingsView: View {
    
    let youtubeUrl = URL(string: "https://www.youtube.com/c/swiftfullthinking")!
    let coffeUrl = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coinGeckoUrl = URL(string: "https://www.coingecko.com")!
    let githubUrl = URL(string: "https://github.com/oguzhanabuhanoglu")!
    let linkednUrl = URL(string: "https://www.linkedin.com/in/o%C4%9Fuzhan-abuhano%C4%9Flu-979985205/")!
    
    var body: some View {
        NavigationView {
            List{
                swiftfulThinkingSection
                developerSection
                coinGeckoSection
                
            }
            .accentColor(.blue)
            .font(.headline)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
            
        }
    }
    
    
    
}

#Preview {
    SettingsView()
}


extension SettingsView {
    
    private var swiftfulThinkingSection: some View {
        Section("Swiftful Thinking") {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @SwiftfulThinking course on Youtube. It uses MVVM Architecture, Combine and CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            
            Link("Subscribe on Youtube", destination: youtubeUrl)
            Link("Support his coffee addiction", destination: coffeUrl)
        }
    }
    
    private var developerSection: some View {
        Section("Developer") {
            VStack(alignment: .leading) {
                Image("me")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("I started learning SwiftUI by following the Swiftful Thinking YouTube channel. The project benefits from multi-threading, publishers/subscribers, CoreData and NetworkingLayer.")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            
            Link("GitHub", destination: githubUrl)
            Link("Linledin", destination: linkednUrl)
        }
    }
    
    private var coinGeckoSection: some View {
        Section("Coin Gecko") {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptoCurrency data that is used in this app comes from a free API from CoinGecko!")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            
            Link("Visit CoinGecko", destination: coinGeckoUrl)
        }
    }
}
