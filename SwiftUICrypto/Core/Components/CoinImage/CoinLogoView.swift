//
//  CoinLogoView.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 29.05.2024.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel

    var body: some View {
        
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .foregroundColor(Color.theme.accent)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .foregroundColor(Color.theme.secondaryText)
                .font(.caption)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.instance.coin)
}
