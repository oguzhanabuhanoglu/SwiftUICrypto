//
//  CoinDetailViewModel.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 31.05.2024.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancelables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
    }
    
    private func addSubscriber() {
        
        coinDetailDataService.$coinDetails
            .sink { (returnedDetails) in
                print(returnedDetails)
            }
            .store(in: &cancelables)
    }
    
}
