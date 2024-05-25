//
//  CircleButtonAnimation.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 13.05.2024.
//

import SwiftUI

struct CircleButtonAnimation: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? Animation.easeInOut(duration: 0.5) : .none)
            /*.onAppear{
                animate.toggle()
            }*/
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(false))
        .foregroundColor(.red)
        .frame(width: 100, height: 100)
}
