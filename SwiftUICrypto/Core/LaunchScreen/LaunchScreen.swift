//
//  LaunchScreen.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 3.06.2024.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map({ String($0) })
    @State private var showLoadingText: Bool = false
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack{
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            // i am not using vStack to be sure the image is center off the all screen
            ZStack {
                if showLoadingText {
                    HStack(spacing: 2){
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
                
        }
        .onAppear{
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring) {
                
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                    
                } else {
                    counter += 1
                }
                
            }
        })
    }
}

#Preview {
    LaunchScreen(showLaunchView: .constant(true))
}