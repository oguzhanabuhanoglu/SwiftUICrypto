//
//  DetailsView.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 31.05.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailsView(coin: coin)
            }
        }
    }
}

struct DetailsView: View {
    
    var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initiazing Detail View for \(coin.name)")
    }
    
    var body: some View {
        Text(coin.name)
    }
    
}

#Preview {
    DetailsView(coin: DeveloperPreview.instance.coin)
}
