//
//  CoinImageView.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 25.05.2024.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel){
        // stateObjecte refereans vermek için "_" kullanmak gerekli.
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.instance.coin)
        .previewLayout(.sizeThatFits)
}
