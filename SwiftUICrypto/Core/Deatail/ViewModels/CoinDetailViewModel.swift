//
//  CoinDetailViewModel.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 31.05.2024.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    
    let coin: CoinModel
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancelables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscriber()
    }
    
    private func addSubscriber() {
        
        coinDetailDataService.$coinDetails
            .sink { (returnedDetails) in
                print(returnedDetails)
            }
            .store(in: &cancelables)
    }
    
}
